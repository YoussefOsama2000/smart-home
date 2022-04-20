import 'package:flutter/material.dart';
import 'loading.dart';
import 'control.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SmartHome());
}

class SmartHome extends StatelessWidget {
  SmartHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0D1826),
      ),
      routes: {
        '/loadingScreen': (context) => LoadingScreen(),
        '/controllscreen': (context) => ControlScreen(),
      },
      initialRoute: '/loadingScreen',
    );
  }
}
