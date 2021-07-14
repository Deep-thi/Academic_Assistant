import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:async';
import './gpa_calc7.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GPA7 extends StatefulWidget{
  final double score7;
  GPA7(this.score7);
  @override
  GPAState7 createState() => new GPAState7(score7);
}
class GPAState7 extends State<GPA7>{
  SharedPreferences prefs;
  TextEditingController controller = new TextEditingController();
  int n7;
  final double score7;
  GPAState7(this.score7);
  double res7;
  initState() {
    super.initState();
    init();
  }

  void init() async{
    prefs = await SharedPreferences.getInstance();
    prefs.commit();
    res7 = (prefs.getDouble('res7') ?? 0);
    setState(() {
      res7;
    });

  }
  void set()
  {
    setState(() {
      res7=score7;
    });
    prefs.setDouble('res7', res7);
  }
  @override
  Widget build(BuildContext context){

    return new Scaffold(
      appBar: new AppBar(title: new Text("GPA calculator"), backgroundColor: Colors.purple[800]),
      backgroundColor: Colors.white,
      body: new Container(
        decoration: new BoxDecoration(border: new Border.all(color: Colors.transparent,width: 25.0),color: Colors.transparent),
        child: new ListView(
          children: <Widget>[
            new TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: InputDecoration(hintText: 'How many Subjects did you have',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.purple[800],
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.purple[100],
                    width: 2.0,
                  ),
                ),),
              /*decoration: new InputDecoration(
                  fillColor: Colors.deepOrangeAccent,

                  hintText: "How many subjects did you have ",
                  hintStyle: new TextStyle(color: Colors.black54)
              ),*/
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: (String str){
                setState((){
                  if(controller.text=="")
                    n7=0;
                  n7=int.parse(controller.text);
                });
              },
            ),
            new IconButton(
              icon:new Icon(Icons.arrow_forward),
              onPressed: (){
                if(n7 is int && n7>0){
                  int pass=n7;
                  n7=0;
                  controller.text="";
                  Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=>new GPAcalc7(pass)));
                }
                else{
                  controller.text="";
                  alert();
                }
              },
            ),
            new Padding(
                padding: EdgeInsets.all(20)
            ),
            //new FlatButton(onPressed: (){set();}, child: new Text('Refresh GPA')),
            new ElevatedButton(
                child: new Text("Refresh GPA"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple[800],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    textStyle: TextStyle(
                      fontSize: 17,
                    )
                ),
                onPressed: (){set();}
            ),
            new Padding(
                padding: EdgeInsets.all(20)
            ),
            new Container(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Your GPA : " + res7.toStringAsFixed(res7.truncateToDouble() == res7 ? 0 : 3),style: new TextStyle(color: Colors.purple[800],fontWeight: FontWeight.bold,fontSize: 25.0)),
                    //new Text(res.toStringAsFixed(res.truncateToDouble() == res7 ? 0 : 3),style: new TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 25.0)),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<Null> alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Alert!'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Please enter some value to calculate'),
                new Text(''),
              ],
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



