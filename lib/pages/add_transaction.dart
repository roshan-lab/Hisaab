import 'package:budget_management_system/controller/database_help.dart';
import 'package:flutter/material.dart';
import 'package:budget_management_system/static.dart' as Static;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  int? amount;
  String note ="Some expense";
  String type="INCOME";
  late SharedPreferences preferences;
  DateTime SelectedDate =DateTime.now();
  List<String> months =
  [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
  Future<void> _selectDate(BuildContext context) async
  {
    final DateTime? picked =await showDatePicker(context: context,
      initialDate: SelectedDate,
      firstDate: DateTime(2000,1),
      lastDate: DateTime(2200,12),
    );
    if(picked != null && picked !=SelectedDate)
      {
        setState(()
        {
          SelectedDate =picked;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Transaction",

          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        //toolbarHeight: 0.0,
      ),
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(
            width: 15.0,
            height: 30.0,
          ),

          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/piglet.png",
              width: 50,
                height: 200,
              ),
            ),

          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              shape: BoxShape.rectangle,
              color: Static.PrimaryColor,
            ),
            padding: EdgeInsets.all(8),
            child: Text("Hey buddy! I'm Dr. Piglet,\n I will keep your transaction history safe.",
            textAlign: TextAlign.center,
            style:TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,

            )
              ,),
          ),


          // Text(
          //     "Add Transaction",
          //
          // textAlign: TextAlign.center,
          // style: TextStyle(
          //   color: Colors.teal.shade800,
          //   fontSize: 32.0,
          //   fontWeight: FontWeight.bold,
          // ),
          // ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                child: Text(" ₹ ",
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "0",
                    //border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  onChanged: (val){
                    try{
                      amount=int.parse(val);
                    }
                    catch(e){

                    }
                  },
                  inputFormatters:[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.description,
                  size: 35.0,
                  color: Colors.white,
                )
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Details/ Comments",

                    // border: InputBorder.none,

                  ),
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  onChanged: (val){
                    note =val;
                },
                  maxLength: 50,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.moving_outlined,
                    size: 37.0,
                    color: Colors.white,
                  )
              ),
              SizedBox(
                  width: 15.0,
                height: 20,
              ),
              Expanded(
                child: ChoiceChip(
                  label: SizedBox(
                      height: 20,
                      child: Text("INCOME",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: type =="INCOME" ?Colors.green.shade900: Colors.black,
                      ),
                      ),
                  ),
                  selected: type =="INCOME" ?true : false,
                  onSelected: (val){
                    if(val)
                      {
                        setState((){
                          type ="INCOME";
                        });
                      }
                  },
                  selectedColor: Static.PrimaryColor,
                ),
          ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(child: ChoiceChip(
                label: SizedBox(
                  height: 20,
                  child: Text("SPENT",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: type =="SPENT" ?Colors.green.shade900: Colors.black,
                    ),
                  ),
                ),
                selected: type =="SPENT" ?true : false,
                onSelected: (val){
                  if(val)
                  {
                    setState((){
                      type ="SPENT";
                    });
                  }
                },
                selectedColor: Static.PrimaryColor,
              ),
              ),
    ],

          ),
          SizedBox(
            width: 15.0,
            height: 15,
          ),
          TextButton(onPressed: (){
            _selectDate(context);
          },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.zero,
              ),
            ),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Static.PrimaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.date_range_outlined,
                        size: 35.0,
                        color: Colors.white,
                      )
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                      "${SelectedDate.day}" "${months[SelectedDate.month-1]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ),
          SizedBox(
            width: 30.0,
            height: 25,
          ),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(onPressed:() async{
              if (amount !=null && note.isNotEmpty){
                DbHelper dbHelper =DbHelper();
                await dbHelper.addData(amount!, SelectedDate, note, type);
                Navigator.of(context).pop();
              }
              else{
                print('Missing Value');
              }
            },
                child: Text(
                  "ADD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,

                ),),

            ),
          ),
      ],
    ),
    );
  }
}

