
import 'package:flutter/cupertino.dart';
import 'confirm_dialog.dart';
import 'package:budget_management_system/controller/database_help.dart';
import 'package:budget_management_system/pages/add_transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:budget_management_system/static.dart' as Static;
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper= DbHelper();
  late SharedPreferences preferences;
  late Box box;
  int totalBalance =0;
  int totalExpense =0;
  int totalIncome =0;
  DateTime today= DateTime.now();
  List<FlSpot> dataSet =[];
  List<String> months =
  [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];


  List<FlSpot> getPlotPoints(List<TransactionModal> entireData){
    dataSet =[];
    // entireData.forEach((key, value) {
    //   if(value['type'] == "SPENT" && (value['date'] as DateTime).month==today.month){
    //     dataSet.add(FlSpot(
    //         (value['date'] as DateTime).day.toDouble(),
    //         (value['amount'] as int).toDouble(),
    //
    //     ),
    //     );
    //    // print(entireData);
    //   }
    //
    //   //   print(entireData);
    //
    // }
    // );


    List tempDataSet =[];
    for(TransactionModal data in entireData){
      if(data.date.month ==today.month && data.type=="SPENT"){
        tempDataSet.add(data);
      }
    }
    tempDataSet.sort((a,b)=>a.date.day.compareTo(b.date.day));
    for(var i=0;i<tempDataSet.length;i++){
      dataSet.add(FlSpot(tempDataSet[i].date.day.toDouble(), tempDataSet[i].amount.toDouble())
      );
    }

    return dataSet;

  }

  getTotalBalance( List<TransactionModal> entireData){
    totalExpense =0;
    totalIncome =0;
    totalBalance =0;

    for(TransactionModal data in entireData){
      if(data.date.month == today.month){
        if(data.type=="INCOME"){
         totalBalance +=data.amount;
         totalIncome += data.amount;
        }
        else
          {
            totalBalance -=data.amount;
            totalExpense +=data.amount;

          }
      }
    }
  }
  getPreference() async {
    preferences= await SharedPreferences.getInstance();
  }

  Future<List<TransactionModal>> fetch() async{
    if(box.values.isEmpty){
      return Future.value([]);
    }
    else{
      List<TransactionModal> items =[];
      box.toMap().values.forEach((element) {
        //print(element);
        items.add(TransactionModal(element['amount'] as int, element['date'] as DateTime, element['note'],element['type'],
        ),
        );
      });
      return items;
    }


  }

  @override
  void initState(){
    super.initState();
    getPreference();
    box=Hive.box('money');
    fetch();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 0.0,
        title: Text("Expense History",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: Colors.pinkAccent,
          elevation: 5,
          backgroundColor: Color(0xffee85b6),
        ),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=>AddTransaction(),
          ),
          ).whenComplete(() {
            setState((){

            });
          });
        },
        // backgroundColor: Static.PrimaryColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10),
        //
        // ),
        child:Text(
          "New Transaction",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<TransactionModal>>(
        future: fetch(),
        builder: (context, snapshot) {
         /////////////dbHelper.delete(1);
          if(snapshot.hasError){
            return Center(
              child: Text("Unexpected Error"),
            );
          }
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Center(
                child: Text("No Values Found"),
              );
            }
             getTotalBalance(snapshot.data!);
             getPlotPoints(snapshot.data!);
             return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60.0),
                              color: Colors.white,
                              ),

                          padding: EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              maxRadius: 45.0,
                              child: Image.asset(
                                  "assets/Rupee.png",
                              width: 80.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30.0,
                        height: 40.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(

                          // border: Border.all(
                          //   width: 5.0,
                          //   //color: Static.PrimaryColor,
                          //   color: Colors.black26
                          // ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(

                          "Welcome \n${preferences.getString('name')}",
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                           // color: Static.PrimaryMaterialColor[900],
                           color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:[
                        Static.PrimaryColor,
                          Colors.blue.shade700,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Total Balance",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "RS $totalBalance",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(10.0,
                        ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [cardIncome(totalIncome.toString(),
                            ),
                              cardExpense(
                                totalExpense.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(12.0),
                  child: Text("Expenses",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                dataSet.length <2
                    ?Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(0,4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 30.0),
                  margin: EdgeInsets.all(10.0),
                  child: Text("Not Enough Data",
                  style: TextStyle(
                    fontSize:20.0 ,
                    color: Colors.black,
                  ),
                  ),
                )
                : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(0,4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 30.0),
                  margin: EdgeInsets.all(10.0),
                  height: 400.0,
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getPlotPoints(snapshot.data!),
                              isCurved :false,
                          barWidth: 2.5,
                          color: Static.PrimaryColor,
                        ),
                      ]
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.all(12.0),
                  child: Text("Recent Transaction",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                ListView.builder(
                shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                  TransactionModal dataAtIndex;

                  try{
                    dataAtIndex =snapshot.data![index];

                  }
                  catch(e){
                    return Container();

                  }

                      if(dataAtIndex.type =="INCOME"){
                    return incomeTile(
                      dataAtIndex.amount,
                      dataAtIndex.note,
                      dataAtIndex.date,
                      context,
                      index,
                      setState,
                    );
                  }else
                    {
                      return expenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        context,
                        index,
                        setState,
                      );
                    }
          },
                ),

                SizedBox(
                  height: 80,
                ),
              ],

            );
          }
          else{
            return Center(
              child: Text("Unexpected Error"),
            );
          }
          }
      ),
    );
  }
}



Widget cardIncome(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(6),
        child: Icon(
          Icons.arrow_downward,
          size: 30,
          color: Colors.greenAccent,

        ),
        margin: EdgeInsets.only(right: 10),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Income",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ],
  );
}

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(6),
          child: Icon(
            Icons.arrow_upward,
            size: 30,
            color: Colors.red,

          ),
          margin: EdgeInsets.only(right: 10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expense",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget expenseTile(int value, String note, DateTime date, BuildContext context, int index, dynamic SETSTATE)
  {
    DbHelper dbHelper= DbHelper();
    List<String> months =
    [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
    return InkWell(
      onLongPress: () async{
       bool? answer=await showConfirmDialog(context, "Warning", "Do You Want To Delete This Record?");
       if(answer !=null && answer){
         dbHelper.deleteData(index);
         SETSTATE((){});

       }
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_circle_up_outlined,
                    size: 28.0,
                      color: Colors.red.shade700,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("Expense",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${date.day} ${months[date.month-1]}",
                    style: TextStyle(color: Colors.blueGrey.shade900,

                    ),


                ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '-$value',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(padding: EdgeInsets.all(7.0),
                ),
                Text(
                  note,
                  style: TextStyle(
                color: Colors.blueGrey.shade900,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
Widget incomeTile(int value, String note, DateTime date,BuildContext context, int index, dynamic SETSTATE)
{
  DbHelper dbHelper= DbHelper();
  List<String> months =
  [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
  return InkWell(
    onLongPress: () async{
      bool? answer=await showConfirmDialog(context, "Warning", "Do You Want To Delete This Record?");
      if(answer !=null && answer){
        dbHelper.deleteData(index);
        SETSTATE((){});

      }
    },
    child: Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_circle_down_outlined,
                    size: 28.0,
                    color: Colors.greenAccent,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("Income",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                 "${date.day} ${months[date.month-1]}",////////// date time

                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.blueGrey.shade900,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "$value",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  note,
                  style: TextStyle(
                    color: Colors.blueGrey.shade900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),


    ),
  );
}

