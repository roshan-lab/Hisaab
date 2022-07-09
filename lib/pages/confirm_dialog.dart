import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showConfirmDialog( BuildContext context, String title, String content) async {
  return await showDialog(
      context: context,
      builder: (context)=> AlertDialog(
    title: Text((title),
    ),
    content: Text(content),
    actions: [
      ElevatedButton(onPressed: (){
        Navigator.of(context).pop(true);
      },
          child: Text("Yes"),
      ),
      ElevatedButton(onPressed: (){
        Navigator.of(context).pop(false);
      },
        child: Text("No",
        ),
      ),


    ],
      ),
  );

}