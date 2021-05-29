import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 120, bottom: 48),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/logo.png')),
                SizedBox(height: 10),
                Text(
                  "Checklist",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.teal),
                ),
                Text(
                  "A todo list app",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey),
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 12, bottom: 12),
                    elevation: 0),
                onPressed: () {
                  Navigator.pushNamed(context, "/home");
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
