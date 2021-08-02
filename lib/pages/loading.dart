import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:bwadr/services/adress_data.dart';
import 'package:bwadr/services/contact_data.dart';

class Loading extends StatefulWidget{
  @override 
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{

  void initData() async {
    await AdressData.getAdresses();    
    await ContactData.getContacts();
    print (ContactData.contacts);
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override initState(){
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.green[400],
        body: Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 50.0,
          ),
        ),
    );
  }
}
