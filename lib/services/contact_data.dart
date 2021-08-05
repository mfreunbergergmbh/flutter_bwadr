import 'package:bwadr/model/contact.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class ContactData {

  //WEBWARE REST API connection parameters
  static String passID = "c1af3be6973834eb66ee709e9e0102ce";
  static String appID = "54261605f4daf3243cefed851ea3c7ff";

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
    DateTime stamp = DateTime.now();
    String hash = md5.convert(utf8.encode(appID+stamp.toString())).toString();
    var header = {
      'Accept' : '*/*',
      'Connection' : 'keep-alive',
      'Accept-Encoding' : 'gzip, deflate, br',
      'Content-Type' : 'application/json',
      'WWSVC-EXECUTE-MODE' : 'SYNCHRON',
      'WWSVC-HASH' : hash,
      'WWSVC-REQID' : reqID.toString(),
      'WWSVC-TS' : stamp.toString(), 
    };
    var body = {
      'WWSVC_FUNCTION' : {
        'FUNCTIONNAME' : 'ANSPRECHPARTNER.GET',
        'REVISION' : '3', 
        'PARAMETER' : [
          {
          'PCONTENT' : number,
          'PNAME' : 'VON_ADRNR' ,
          'POSITION' : 1,
          'PTYPE' : 'R0',
          },
          {
          'PCONTENT' : number,
          'PNAME' : 'VON_ADRNR' ,
          'POSITION' : 1,
          'PTYPE' : 'R0',
          },
        ],
      },
      'WWSVC_PASSINFO' : {
        'APPHASH' : hash,
        'EXECUTE_MODE' : 'SYNCHRON' ,
        'REQUESTID' : reqID,
        'SERVICEPASS' : passID,
        'TIMESTAMP' : stamp.toString(),
      },
    };

    Uri apiURI = Uri.https(urlLocation, urlExtended);

    try {
      Response response = await put(apiURI, headers: header, body: json.encode(body));
      if(response.statusCode == 200){
        var decoded = json.decode(response.body);
        List loadedContacts = decoded['ANSPRECHPARTNERLISTE']["ANSPRECHPARTNER"];
        for(dynamic contact in loadedContacts){
          contacts.add(Contact(
                  adressNumber: contact['ANP_1_8'], 
                  firstName: contact['ANP_1675_30'], 
                  lastName: contact['ANP_1705_40'], 
                  telNumber: contact['ANP_91_40'], 
                  email: contact['ANP_1210_60']));
        }
      }
    }catch (e){
      print(e);
    }
  }
}
