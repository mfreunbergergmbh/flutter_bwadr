import 'package:flutter/material.dart';
import 'package:bwadr/database/database.dart';

class Settings extends StatefulWidget{
  @override 
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>{

  String domain = "";
  String appID = "";
  String herID = "";
  String zugID = "";
  String revID = "";

  @override initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget> [
          Text("Domain"),
          TextField(
            onChanged: (text){
              domain = text;
            },
          ),
          Text("appid"),
          TextField(
            onChanged: (text){
              appID = text;
            },
          ),
          Text("herstellerid"),
          TextField(
            onChanged: (text){
              herID = text;
            },
          ),
          Text("zugang id"),
          TextField(
            onChanged: (text){
              zugID = text;
            },
          ),
          Text("revision"),
          TextField(
            onChanged: (text){
              revID = text;
            },
          ),
          FlatButton(
            child: Text("Speichern"),
            onPressed : (){
              createServicePass();
            },
          ),
        ],
      ),
    );
  }

  void createServicePass(){
    print("Creating Service Pass");
    DataBase.passExists();
    DataBase.registerPass(domain: domain, appID: appID, herID: herID, zugID: zugID, revID: revID);
  }
}
