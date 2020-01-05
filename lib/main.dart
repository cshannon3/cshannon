/*
Main features - ui layout mode for when editing
Once editing is done you can 'freeze' to data which saves app in data that can be instantly parsed by the app itself,
allowing for 'no-code' updates to apps and websites
or 'freeze' into code which you can then copy and past into a dart file


To be able to do this, first in and out of gui mode,


*/
import 'dart:async';
import 'dart:math';

/*
Main features - ui layout mode for when editing
Once editing is done you can 'freeze' to data which saves app in data that can be instantly parsed by the app itself,
allowing for 'no-code' updates to apps and websites
or 'freeze' into code which you can then copy and past into a dart file


To be able to do this, first in and out of gui mode,


*/

import 'package:cshannon/components/animated_list.dart';
import 'package:cshannon/state_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
/*
    try {
    fb.initializeApp(
       apiKey: "AIzaSyDU-vLIua4u1l0i2LikrZIMV3YTqoDynOA",
    authDomain: "portfolio-27dc5.firebaseapp.com",
    databaseURL: "https://portfolio-27dc5.firebaseio.com",
    projectId: "portfolio-27dc5",
    storageBucket: "portfolio-27dc5.appspot.com",
    messagingSenderId: "616077941152",
    
    //appId: "1:616077941152:web:2273ab53f446b9287d2cc5",
    //measurementId: "G-50EGC0S52Y"
    );

    
    runApp(MyApp());
    
  } on fb.FirebaseJsNotLoadedException catch (e) {
    print(e);
  }*/
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootApp(), 
    );
  }
}


class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  StateManager stateManager = StateManager();
TextInputClient p;
  //Navigation navigation;
  @override
  void initState() {
    super.initState();
      stateManager.addListener(() {
      setState(() {});
    });

    //var db = fb.firestore();
    stateManager.initialize();
    

    
    // refresh when ui manager is called so that screen changes
 
  
  }
  
  Widget menubutton({String name, Function onPress}) { //, double width
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child:SizedBox.fromSize(
        size: stateManager.sc.menuButton(),
          child: MaterialButton(
            color: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            onPressed: onPress ?? () {},
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: stateManager.sc.getMenuFontSize(),
                  fontStyle: FontStyle.italic),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print("Update");
    //print(MediaQuery.of(context).size);
    stateManager.setScale(MediaQuery.of(context).size);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(195, 20, 50, 1.0),
                Color.fromRGBO(36, 11, 54, 1.0)
              ]),
        ),
        child: Stack(
          children: <Widget>[
  
            Positioned.fromRect(
              rect: stateManager.sc.mainArea(),
           
               child: 
              stateManager.getScreen()
             // ),   // navigation.getCurrentScreen()(),),
            ),
          CustomAnimatedList(
          introDirection: stateManager.sc.mobile?DIREC.LTR: DIREC.BTT,
          //size: Size(w,h),
          lrtb: stateManager.sc.menu(),
          widgetList: <Widget>[
            menubutton(name: "Home", //width: .2 * w,
            onPress: () => stateManager.changeScreen("/")
            ),
             menubutton(name: "Sites", //width: .2 * w,
            onPress: () => stateManager.changeScreen("/sites")
            ),
            menubutton(name: "Essays", //width: .2 * w,
            onPress: () => stateManager.changeScreen("/essays")
            ),
            menubutton(name: "Books", //width: .2 * w,
            onPress: () => stateManager.changeScreen("/books")),
            menubutton(
                name: "Quotes",
               // width: .2 * w,
                onPress: () => stateManager.changeScreen("/quotes")),
           
          ],
          
  
        ),
          ],
        ),
      ),
    );
  }
}

  // child: SizedBox(width: w*0.85, height: h , 