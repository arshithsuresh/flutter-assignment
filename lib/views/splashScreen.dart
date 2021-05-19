import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 120, bottom:48),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/logo.png')),
              Text("Todo List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
              Text(" My todo list app", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),            
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: EdgeInsets.only(left:40,right:40,top:12,bottom:12),
              elevation: 0
            ),
          
            onPressed: (){
              Navigator.pushNamed(context, "/home");
            }, 
            child: Text("Go >>", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}