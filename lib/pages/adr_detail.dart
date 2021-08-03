import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:bwadr/services/adress_data.dart';
import 'package:bwadr/services/contact_data.dart';
import 'package:bwadr/model/adress.dart';
import 'package:bwadr/widgets/contact_card.dart';
import 'package:bwadr/model/contact.dart';

class AdressDetail extends StatefulWidget{
  @override 
  _AdressDetailState createState() => _AdressDetailState();
}

class _AdressDetailState extends State<AdressDetail>{

  Adress adress = Adress(name: "Nicht gefunden", number: "nan");
  List<Contact> contacts = [];

  @override initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    Map args = ModalRoute.of(context)?.settings.arguments == null ? {} : ModalRoute.of(context)?.settings.arguments as Map;
    if (args.containsKey("adressNumber")){
      adress = AdressData.getAdress(args["adressNumber"]);
      contacts = ContactData.contactList(number: args["adressNumber"]);
    }
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Adress Detail"), 
          centerTitle: true,
          elevation: 3.0,
          backgroundColor: Colors.green[400],
        ),
        body: Column(
          children: <Widget>[
            AdressInfo(), 
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
                    child: Divider(height: 20.0),
                  ),
                ),
                Text("Ansprechpartner"),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
                    child: Divider(height: 20.0),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactCard(contact: contacts[index]);
                },
              ),
            ),
          ],
        ),
      );
    }

  Widget AdressInfo(){
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Icon(
          Icons.account_circle_outlined,
          size: 80.0
        ),
        SizedBox(height: 10.0),
        Text(
          adress.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          adress.number,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(height: 5.0),
      ],
    );
  }
}
