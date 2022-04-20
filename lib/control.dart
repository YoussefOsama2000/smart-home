import 'package:flutter/material.dart';
import 'customButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'acTemp.dart';
import 'valuesClass.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  DataCenter dataCenter = DataCenter();
  String enteredPassword = '';
  String password = 'open';
  int roomTemp = 28;
  bool isConnected = false;
  dynamic snapshotData;
  final database = FirebaseDatabase.instance.ref();

  Future<void> updateOnlineValues(DatabaseReference ref) async {
    if (isConnected) {
      ref.update({
        'option1': dataCenter.access['option1']?.getOfflineValue(),
        'Door': dataCenter.access['door']?.getOfflineValue(),
        'option3': dataCenter.access['option3']?.getOfflineValue(),
        'AC': dataCenter.access['AC']?.getOfflineValue(),
        'ACTemp': dataCenter.access['ACTemp']?.getOfflineValue(),
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database.child('Smart Home').onValue.listen((event) {
      snapshotData = event.snapshot.value;
      getOnlineValues();
      updateConnectionState();
    });
  }

  getOnlineValues() async {
    if (isConnected) {
      setState(() {
        dataCenter.access['option1']?.setOnlineValue(snapshotData['option1']);
        dataCenter.access['door']?.setOnlineValue(snapshotData['door']);
        dataCenter.access['option3']?.setOnlineValue(snapshotData['option3']);
        dataCenter.access['AC']?.setOnlineValue(snapshotData['AC']);
        dataCenter.access['ACTemp']?.setOnlineValue(snapshotData['ACTemp']);
        roomTemp = snapshotData['roomTemp'];
      });
    }
  }

  Future<void> updateConnectionState() async {
    bool newIsconnected = await SimpleConnectionChecker.isConnectedToInternet();
    setState(() {
      isConnected = newIsconnected;
    });
    await Future.delayed(Duration(seconds: 1));
    updateConnectionState();
  }

  @override
  Widget build(BuildContext context) {
    getOnlineValues();

    final smartHomeDataRef = database.child('Smart Home');
    updateOnlineValues(smartHomeDataRef);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.circle,
                  color: isConnected ? Colors.green : Colors.red,
                  size: 20,
                ),
              ),
              Expanded(
                child: GridView(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            roomTemp.toString() + '°C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'current room temperature',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                        theIconData: Icons.lightbulb,
                        text: 'option 1',
                        state: dataCenter.access['option1']?.offlineValue,
                        upToDate: isConnected,
                        onTapping: () {
                          setState(() {
                            dataCenter.access['option1']?.reverseOfflineValue();
                          });
                        }),
                    CustomButton(
                        theIconData: Icons.door_front_door,
                        text: 'Door',
                        state: dataCenter.access['door']?.offlineValue,
                        upToDate: isConnected ?? true,
                        onTapping: () {
                          if (dataCenter.access['door']?.offlineValue ==
                              false) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Enter password to unlock'),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        TextField(
                                          onChanged: (txt) {
                                            enteredPassword = txt;
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                if (enteredPassword ==
                                                    password) {
                                                  setState(() {
                                                    dataCenter.access['door']
                                                        ?.reverseOfflineValue();
                                                    Navigator.pop(context);
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: 'wrong password');
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text(
                                                'Enter',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                  backgroundColor: Color(0xFF1E2937),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                );
                              },
                            );
                          }
                          setState(() {
                            if (dataCenter.access['door']?.offlineValue == true)
                              dataCenter.access['door']?.reverseOfflineValue();
                          });
                        }),
                    CustomButton(
                        theIconData: Icons.tv,
                        text: 'option 3',
                        state: dataCenter.access['option3']?.offlineValue,
                        upToDate: isConnected ?? true,
                        onTapping: () {
                          setState(() {
                            dataCenter.access['option3']?.reverseOfflineValue();
                          });
                        }),
                    CustomButton(
                        theIconData: Icons.air,
                        text: 'AC',
                        state: dataCenter.access['AC']?.offlineValue,
                        upToDate: isConnected ?? true,
                        onTapping: () {
                          setState(() {
                            dataCenter.access['AC']?.reverseOfflineValue();
                          });
                        }),
                    dataCenter.access['AC']?.offlineValue
                        ? AcTemp(
                            onAdding: () {
                              setState(() {
                                int newValue =
                                    dataCenter.access['ACTemp']?.offlineValue +
                                        1;
                                dataCenter.access['ACTemp']
                                    ?.setOfflineValue(newValue);
                              });
                            },
                            onRemoving: () {
                              setState(() {
                                int newValue =
                                    dataCenter.access['ACTemp']?.offlineValue -
                                        1;
                                dataCenter.access['ACTemp']
                                    ?.setOfflineValue(newValue);
                              });
                            },
                            airConditionerTemp:
                                dataCenter.access['ACTemp']?.offlineValue,
                            uptoDate: isConnected ?? false)
                        : SizedBox(
                            width: 0,
                            height: 0,
                          ),
                  ],
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      childAspectRatio: 2.7 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
