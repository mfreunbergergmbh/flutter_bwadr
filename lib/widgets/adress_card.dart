import 'package:bwadr/model/adress.dart';
import 'package:flutter/material.dart';

class AdressCard extends StatelessWidget{
  Adress adress; 

  AdressCard({required this.adress});

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
                child: AdressHeader(context),
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
                child: AdressInfo(), 
              ),
            ]
          ),
        ),
      ),  
    );
  }

  Widget AdressHeader(BuildContext context){
    return ListTile(
        onTap: (){
          Navigator.pushNamed(context, "/", arguments: {
            'adressNumber' : adress.number,
          });
        },
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
                adress.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Text(
                adress.number,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }

  Widget AdressInfo(){
    return Padding (
        padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
        child: Row( 
          children: <Widget> [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: (){
                    print("Sending EMAIL");
                  },
                  icon: Icon(Icons.email_outlined),
                  label: Text(adress.email,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                FlatButton.icon(
                  onPressed: (){
                    print("Sending Tel. Number");
                  },
                  icon: Icon(Icons.call_outlined),
                  label: Text(adress.telNumber,
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

