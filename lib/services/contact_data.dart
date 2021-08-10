import 'package:bwadr/model/contact.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:bwadr/database/database.dart';

class ContactData {

  //WEBWARE REST API connection parameters
  static String passID = "53f9f3e23bf57ab8b4a81710fc921f4a";
  static String appID = "0dedc0c1fc87eddd97c61f3027720349";

  static String urlLocation = "demoww.freunberger.com:1547";
  static String urlExtended = "/WWSVC/EXECJSON/";

  static int reqID = 1;

  static List<Contact> contacts = [];

  static List<Contact> contactList({String number="0"}){
    return contacts.where((index)=> index.adressNumber == number).toList();
  }

  static Future<void> getContacts({String number="0"}) async {
    if (contacts.where((index) => index.adressNumber == number ).length > 0) {
      return; 
    }
    try {
      Map<String, dynamic?> decoded = await DataBase.getContacts(number: number);
      List loadedContacts = decoded['ANSPRECHPARTNERLISTE']["ANSPRECHPARTNER"];
      for(dynamic contact in loadedContacts){
        contacts.add(Contact(
            adressNumber: contact['ANP_1_8'], 
            firstName: contact['ANP_1675_30'], 
            lastName: contact['ANP_1705_40'], 
            telNumber: contact['ANP_91_40'], 
            email: contact['ANP_1210_60'],
            mobileNumber: contact['ANP_1120_20'],
            title: contact['ANP_211_40'],
            pronoun: contact['ANP_1060_30'],
          )
        );
      }
    }catch(e){
      print(e);
    }
  }
}
