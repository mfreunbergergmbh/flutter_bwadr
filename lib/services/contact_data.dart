import 'package:bwadr/model/contact.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class ContactData {

  //WEBWARE REST API connection parameters
  static String passID = "5678156bb43cb7a5179cd55e6ad5ac6c";
  static String appID = "8b223ebcd327370be767fe202428e815";

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
    List<Contact> newContacts = await Future.delayed(Duration(seconds: 5), (){

      //DateTime stamp = DateTime.now();
      //String hash = md5.convert(utf8.encode(appID+stamp.toString())).toString();
      //var header = {
      //  //'Accept' : '*/*',
      //  //'Connection' : 'keep-alive',
      //  //'Accept-Encoding' : 'gzip, deflate, br',
      //  'Content-Type' : 'application/json',
      //  'WWSVC-EXECUTE-MODE' : 'SYNCHRON',
      //  'WWSVC-HASH' : hash,
      //  'WWSVC-REQID' : reqID.toString(),
      //  'WWSVC-TS' : stamp.toString(), 
      //};
      //var body = {
      //  'WWSVC_FUNCTION' : {
      //    'FUNCTIONNAME' : 'ADRESSE.GET',
      //    'REVISION' : '3', 
      //    'PARAMETER' : [{
      //      'PCONTENT' : 'ADR_2_8,ADR_20_30,ADR_2332_20,ADR_1330_60',
      //      'PNAME' : 'FELDER' ,
      //      'POSITION' : 1,
      //      'PTYPE' : 'L',
      //    }],
      //  },
      //  'WWSVC_PASSINFO' : {
      //    'APPHASH' : hash,
      //    'EXECUTE_MODE' : 'SYNCHRON' ,
      //    'REQUESTID' : reqID,
      //    'SERVICEPASS' : passID,
      //    'TIMESTAMP' : stamp.toString(),
      //  },
      //};

      //Uri apiURI = Uri.https(urlLocation, urlExtended);
      ////apiURI = Uri.https("worldtimeapi.org", "/api/timezone/Europ/Vienna");

      //try {
      //  print(header);
      //  Response response = await put(apiURI, headers: header, body: json.encode(body));
      //  if(response.statusCode == 200){
      //    print ("seems like it worked");
      //  }
      //  var decoded = json.decode(response.body);
      //  print(decoded);
      //  List loadedAdresses = decoded['ADRESSLISTE']["ADRESSE"];
      //  print(loadedAdresses);
      //  for(dynamic adress in loadedAdresses){
      //    adresses.add(Adress(number: adress['ADR_2_8'], name: adress['ADR_20_30'], telNumber: adress['ADR_2332_20'], email: adress['ADR_1330_60']));
      //  }
      //}catch (e){
      //  print(e);
      //}
      return <Contact> [
        Contact(adressNumber: "1000", lastName: "Wippel", telNumber: "+43 1234", email: "wippel@mail.com"),
        Contact(adressNumber: "1000", lastName: "Tobias", telNumber: "+43 676 82537146"),
        Contact(adressNumber: "1000", lastName: "Freunberger", telNumber: "+43 664 3922936", email: "bernhard@freunberger.com"),
        Contact(adressNumber: "1000", lastName: "Jasmin", telNumber: "+43 676 3094985"),
        Contact(adressNumber: "1000", lastName: "Hoerhan"),
        Contact(adressNumber: "1001", lastName: "Schrey"),
        Contact(adressNumber: "1002", lastName: "Hoeller"),
      ];
    }); 

    contacts.addAll(newContacts);
  }
}
