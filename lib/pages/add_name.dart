import 'package:budget_management_system/controller/database_help.dart';
import 'package:budget_management_system/pages/homepage.dart';
import 'package:flutter/material.dart';

class AddName extends StatefulWidget {
  const AddName({Key? key}) : super(key: key);

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  DbHelper dnHelper = DbHelper();

  String name ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money"),
        centerTitle: true,

        //toolbarHeight: 0.0,
      ),
      backgroundColor: Colors.pinkAccent.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
               child: Container(
                 decoration: BoxDecoration(
                     color:Colors.white70,
                   borderRadius: BorderRadius.circular(60.0),

                 ),
                padding: EdgeInsets.all(3.0),
              child: Image.asset("assets/Rupee.png",
                width: 100.0,
                height: 100.0,
              ),
            ),
            ),
            SizedBox(
              height: 140.0,
            ),
            Text("How May I Address You?",
              textAlign:TextAlign.right,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              decoration: BoxDecoration(
                color:Colors.white70,
                borderRadius: BorderRadius.circular(60.0),

              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Your Good Name",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                onChanged: (val){
                  name=val;
                },
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(onPressed: (){
                if(name.isNotEmpty){
                  dnHelper.addName(name);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage(),
                  ),
                  );

                }
                else
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: "OK",
                        onPressed: (){
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                      backgroundColor: Colors.white,
                      content: Text(
                        "Please Enter Your Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                  ),
                  );

              },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                      "Good To Go!",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,

                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.navigate_next_outlined,
                      size: 30,

                      ),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
