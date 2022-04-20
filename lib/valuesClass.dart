import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class Item {
  dynamic offlineValue;
  dynamic onlineValue;
  bool uptoDate = false;
  Item({this.offlineValue});
  void reverseOfflineValue() {
    offlineValue = !offlineValue;
    setUpToDate();
  }

  void setOfflineValue(offlineValue) {
    this.offlineValue = offlineValue;
    setUpToDate();
  }

  void setOnlineValue(onlineValue) {
    this.onlineValue = onlineValue;
    setUpToDate();
  }

  void setUpToDate() {
    uptoDate = onlineValue == onlineValue ? true : false;
  }

  dynamic getOfflineValue() async {
    bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    if (isConnected) {
      return offlineValue;
    } else {
      return onlineValue;
    }
  }
}

class DataCenter {
  var access = {
    'option1': Item(offlineValue: false),
    'door': Item(offlineValue: false),
    'option3': Item(offlineValue: false),
    'AC': Item(offlineValue: false),
    'ACTemp': Item(offlineValue: 20)
  };
}
