import 'package:budget_management_system/controller/database_help.dart';
import 'package:budget_management_system/pages/add_name.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DbHelper dbHelper =DbHelper();
  Future getSettings() async{
    String? name= await dbHelper.getName();
    if(name!= null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage(),),);

    }else
      {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AddName(),),);

      }
  }
  @override
  void initState(){
    super.initState();
    getSettings();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 0.0,
      ),
      backgroundColor: Colors.pinkAccent.shade100,
      body: Center(
        // child: Container(
        //   decoration: BoxDecoration(
        //       color:Colors.white70,
        //     borderRadius: BorderRadius.circular(60.0),
        //
        //   ),
        //   padding: EdgeInsets.all(16.0),
          child: Image.asset("assets/Rupee.png",
          width: 250.0,
            height: 250.0,
          ),
          ),
        );
  }
}
