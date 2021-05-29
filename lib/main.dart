import 'package:flutter/material.dart';
import 'package:todoapp/views/homePage.dart';
import 'package:todoapp/views/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firebase.initializeApp().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print("Error!");
          if (snapshot.connectionState == ConnectionState.done)
            return MaterialApp(
                title: 'Checklist',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.teal,
                ),
                initialRoute: '/',
                routes: {
                  '/': (context) => SplashScreen(),
                  '/home': (context) => HomePage()
                });

          return CircularProgressIndicator();
        });
  }
}
