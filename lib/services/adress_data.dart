import 'package:bwadr/model/adress.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AdressData {
  //WEBWARE REST API connection parameters
  static String passID = "7a7307febbaf49bee4ea205609df9838";
  static String appID = "1b95b24f94cc03be6e50df9be2fc1407";

  static String urlLocation = "demoww.freunberger.com:1547";
  static String urlExtended = "/WWSVC/EXECJSON/";

  static int reqID = 1;

  static List<Adress> adresses = [];

  static Adress getAdress(String number){
    for (Adress adress in adresses){
      if (adress.number == number) return adress;
    }
    return Adress(name: "Nicht gefunden", number: "nan");
  }

  static Future<void> getAdresses() async {
    
    //Real REST API Connection
    DateTime stamp = DateTime.now();
    String hash = md5.convert(utf8.encode(appID+stamp.toString())).toString();
    var header = {
      //'Accept' : '*/*',
      //'Connection' : 'keep-alive',
      //'Accept-Encoding' : 'gzip, deflate, br',
      'Content-Type' : 'application/json',
      'WWSVC-EXECUTE-MODE' : 'SYNCHRON',
      'WWSVC-HASH' : hash,
      'WWSVC-REQID' : reqID.toString(),
      'WWSVC-TS' : stamp.toString(), 
    };
    var body = {
      'WWSVC_FUNCTION' : {
        'FUNCTIONNAME' : 'ADRESSE.GET',
        'REVISION' : '3', 
        'PARAMETER' : [{
          'PCONTENT' : 'ADR_2_8,ADR_20_30,ADR_2332_20,ADR_1330_60',
          'PNAME' : 'FELDER' ,
          'POSITION' : 1,
          'PTYPE' : 'L',
        }],
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
    //apiURI = Uri.https("worldtimeapi.org", "/api/timezone/Europ/Vienna");

    try {
      Response response = await put(apiURI, headers: header, body: json.encode(body));
      if(response.statusCode == 200){
        var decoded = json.decode(response.body);
        List loadedAdresses = decoded['ADRESSLISTE']["ADRESSE"];
        for(dynamic adress in loadedAdresses){
          adresses.add(Adress(number: adress['ADR_2_8'], name: adress['ADR_20_30'], telNumber: adress['ADR_2332_20'], email: adress['ADR_1330_60']));
        }
      }
    }catch (e){
      print(e);
    }

    //adresses = await Future.delayed(Duration(seconds: 5), (){
    //  return <Adress> [
    //    Adress(name: "Wippel", number: "1000"),
    //    Adress(name: "Lewacon", number: "1001", telNumber: "+43 667 4929948", email: "mail@example.com"),
    //    Adress(name: "Hoeller", number: "1002"),
    //    Adress(name: "Baustegmuehl", number: "1003"),
    //    Adress(name: "Vario", number: "1004"),
    //    Adress(name: "Luger", number: "1005"),
    //    Adress(name: "MayrEDV", number: "1006"),
    //    Adress(name: "Slunezeck", number: "1007"),
    //    Adress(name: "Softengine", number: "1008"),
    //  ];
    //}); 
  }
}
