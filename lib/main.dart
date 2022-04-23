// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/home/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //make date offline
  //FirebaseFirestore.instance.disableNetwork();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (buildContext) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: MyThemeData.lightTheme,
    );
  }
}
