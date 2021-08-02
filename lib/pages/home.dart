import 'package:flutter/material.dart';
import 'package:bwadr/model/adress.dart';
import 'package:bwadr/widgets/adress_card.dart';
import 'package:bwadr/services/adress_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  bool searchEnabled = false;
  String searchText = "";

  List<Adress> query = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    query = AdressData.adresses.where((index){ // only show searched for data
      return  (index.name.toLowerCase().contains(searchText.toLowerCase()))||
              (index.number.toLowerCase().contains(searchText.toLowerCase()))||
              (index.telNumber.toLowerCase().contains(searchText.toLowerCase()))||
              (index.email.toLowerCase().contains(searchText.toLowerCase()));
    }).toList();

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: searchEnabled ? appBar_search() : appBar_noSearch(),
            centerTitle: true,
            elevation: 3.0,
            backgroundColor: Colors.green[400],
            actions: <Widget>[
              IconButton(
                icon: searchEnabled ? Icon(Icons.close_outlined): Icon(Icons.search_outlined),
                onPressed: (){
                  setState((){
                    if (searchEnabled) {
                      searchEnabled=false;
                    }
                    else if (!searchEnabled){ 
                      searchEnabled=true;
                    }
                  });
                },
              ),
            ],
        ),
        body: ListView.builder(
          itemCount: query.length,
          itemBuilder: (context, index) {
            return AdressCard(adress: query[index]);
          },
        ),
    );
  }

  //default appBar apearance when not currently searching
  Widget appBar_noSearch(){
    return Text(
      "BüroWARE Adressen",
      style: TextStyle(
        color: Colors.green[50],
        fontWeight: FontWeight.bold,
      ),
    );
  }

  //appBar apearance when currently searching
  Widget appBar_search(){
    return TextField(
      onChanged: (text){
        setState((){
          searchText = text;
        });    
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'AdressSuche',
        hintStyle: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.green[500],
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,),
        ),
      ),
    );
  }
}
