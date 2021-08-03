import 'package:bwadr/model/adress.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AdressData {
  //WEBWARE REST API connection parameters
  static String passID = "eac60f1eac7f07c8e8edd92976c398be";
  static String appID = "6760c9a807b7383c78a2b6c56405c613";

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
      'Content-Type' : 'application/json',
      'WWSVC-EXECUTE-MODE' : 'SYNCHRON',
      'WWSVC-HASH' : hash,
      'WWSVC-REQID' : reqID.toString(),
      'WWSVC-TS' : stamp.toString(), 
    };
    var body = {
      'WWSVC_FUNCTIOn' : json.encode({
        'FUNCTIONNAME' : 'ADRESSE.GET',
      }),
      'PARAMETER' : json.encode({
        '0' : json.encode({
          'PCONTENT' : 'ADR_2_8,ADR_20_30,ADR_2332_20,ADR_1330_60',
          'PNAME' : 'FELDER' ,
          'POSITION' : 1,
          'PTYPE' : 'L',
        }),
        'REVISION' : '3',
      }), 
      'WWSVC_PASSINFO' : json.encode({
        'APPHASH' : hash,
        'EXECUTE_MODE' : 'SYNCHRON' ,
        'REQUESTID' : reqID.toString(),
        'SERVICEPASS' : passID,
        'TIMESTAMP' : stamp.toString(),
      }),
    };

    Uri apiURI = Uri.https(urlLocation, urlExtended);
    //apiURI = Uri.https("worldtimeapi.org", "/api/timezone/Europ/Vienna");

    try {
      Response response = await get(apiURI, /*headers: header, body: json.encode(body)*/);
      if(response.statusCode == 200){
        print ("seems like it worked");
      }
      var decoded = json.decode(response.body);
      print("decoded");
    }catch (e){
    }

    adresses = await Future.delayed(Duration(seconds: 5), (){
      return <Adress> [
        Adress(name: "Wippel", number: "1000"),
        Adress(name: "Lewacon", number: "1001", telNumber: "+43 667 4929948", email: "mail@example.com"),
        Adress(name: "Hoeller", number: "1002"),
        Adress(name: "Baustegmuehl", number: "1003"),
        Adress(name: "Vario", number: "1004"),
        Adress(name: "Luger", number: "1005"),
        Adress(name: "MayrEDV", number: "1006"),
        Adress(name: "Slunezeck", number: "1007"),
        Adress(name: "Softengine", number: "1008"),
      ];
    }); 
  }
}
