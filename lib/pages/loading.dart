import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:bwadr/services/adress_data.dart';
import 'package:bwadr/services/contact_data.dart';

class Loading extends StatefulWidget{
  @override 
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{

  void initAdressData() async {
    print("Loading AdressData");
    await AdressData.getAdresses();    
    Navigator.pushReplacementNamed(context, "/home");
  }
  void initContactData(String number) async {
    print("Loading ContactData");
    await ContactData.getContacts(number: number);
    Navigator.pushReplacementNamed(context, "/adr_detail", arguments: {
      "adressNumber" : number ,
    });
  }
  @override initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    Map args = ModalRoute.of(context)?.settings.arguments == null ? {} : ModalRoute.of(context)?.settings.arguments as Map;
    if (args.containsKey("adressNumber")){
      initContactData(args["adressNumber"]);
    }else{
      initAdressData();
    }
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
