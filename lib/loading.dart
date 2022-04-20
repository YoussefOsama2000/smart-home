import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // final Future initialize = Firebase.initializeApp();
  // final database = FirebaseDatabase.instance.ref();
  Future tryingToConnect() async {
    Firebase.initializeApp();

    await Future.delayed(Duration(seconds: 3));
    return FirebaseDatabase.instance.ref();
  }

  Future<void> push() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.pushReplacementNamed(context, '/controllscreen');
    });

    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: FutureBuilder(
            future: tryingToConnect(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                push();
                return const Icon(
                  Icons.check_circle_outline,
                  size: 250,
                  color: Colors.white30,
                );
              } else if (snapshot.hasError) {
                Fluttertoast.showToast(msg: 'couldn\'t connect!');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 200,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ERROR !',
                      style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5),
                    ),
                  ],
                );
              }
              return LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF1A1A3F),
                rightDotColor: const Color(0xFFEA3799),
                size: 200,
              );
            },
          ),
        ),
      ),
    );
  }
}
