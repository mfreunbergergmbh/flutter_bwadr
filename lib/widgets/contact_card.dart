import 'package:bwadr/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget{
  Contact contact;
  ContactCard({required this.contact});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0,10.0,5.0,0.0),
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0,5.0,0.0,5.0),
          child: Column(
            children: <Widget>[
              Container(
                child: ContactHeader(context),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
                child: Divider(
                  height: 16.0,
                  color: Colors.grey,
                  thickness: 0.3,
                ),
              ),
              Container(
                child: ContactInfo(), 
              ),
            ]
          ),
        ),
      ),  
    );
  }

  Widget ContactHeader(BuildContext context){
    return ListTile(
        title: Row(
        children: <Widget> [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.account_circle_outlined,
              size: 40.0,
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                (contact.firstName + contact.lastName),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }

  Widget ContactInfo(){
    return Padding (
        padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
        child: Row( 
          children: <Widget> [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    String url = "mailto:"+contact.email;
                    await launch(url);
                  },
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    contact.email,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                FlatButton.icon(
                  onPressed: () async {
                    String url = "tel:"+contact.telNumber;
                    await launch(url);
                  },
                  icon: Icon(Icons.call_outlined),
                  label: Text(
                    contact.telNumber,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
              ]
            ),
          ]
      ),
    );
  }
}

