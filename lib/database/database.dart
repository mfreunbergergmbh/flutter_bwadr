import 'package:http/http.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBase {

  static int reqID = 0; 

  static Future<void> passExists() async {
    final prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString('PASSID') ?? "";
    String app = prefs.getString('APPID') ?? "";
    String domain = prefs.getString('DOMAIN') ?? "";
    print(pass);
    print(app);
    print(domain);
  }
  static Future<Map<String, dynamic?>> getContacts({String number="0"}) async {

    DataBase.reqID+=1;
    Map<String, dynamic?> decoded = {}; 
    //load connection data from local storage
    final prefs = await SharedPreferences.getInstance();
    String passID = prefs.getString('PASSID') ?? "";
    String appID = prefs.getString('APPID') ?? "";
    String urlLocation = prefs.getString('DOMAIN') ?? "";
    String urlExtended = "/WWSVC/EXECJSON/";

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
        decoded = json.decode(response.body);
      }
    }catch (e){
      print(e);
    }
    return decoded;
  }

  static Future<Map<String, dynamic?>> getAdresses() async {

    DataBase.reqID+=1;
    Map<String, dynamic?> decoded = {}; 
    //load connection data from local storage
    final prefs = await SharedPreferences.getInstance();
    String passID = prefs.getString('PASSID') ?? "";
    String appID = prefs.getString('APPID') ?? "";
    String urlLocation = prefs.getString('DOMAIN') ?? "";
    String urlExtended = "/WWSVC/EXECJSON/";
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
        decoded = json.decode(response.body);
      }
    }catch (e){
      print(e);
    }
    return decoded;
  }

  static Future<void> registerPass({required String domain, required String appID, required String herID, required String zugID, required String revID}) async {

    DateTime stamp = DateTime.now();
    String hash = md5.convert(utf8.encode(appID+stamp.toString())).toString();

    Map<String, String> header = {
      //'Accept' : '*/*',
      //'Connection' : 'keep-alive',
      //'Accept-Encoding' : 'gzip, deflate, br',
      'Content-Type' : 'application/json',
      'Connection' : "keep-alive",
    };

    String extendedUri = "/WWSVC/WWSERVICE/REGISTER/"+
        herID+"/"+appID+"/"+zugID+"/"+revID+"//";
    print(domain+extendedUri);
    Uri apiURI = Uri.https(domain, extendedUri);

    try {
      Response response = await get(apiURI, headers: header);
      if(response.statusCode==202 || response.statusCode==200){
        Map<String, dynamic?> decoded = json.decode(response.body); 
        //saving existing pass to local storage
        final prefs = await SharedPreferences.getInstance();
        String passAppID =decoded["SERVICEPASS"]["APPID"] ;
        String passPassID =decoded["SERVICEPASS"]["PASSID"] ;

        prefs.setString("APPID", passAppID);
        prefs.setString("PASSID", passPassID);
        prefs.setString("DOMAIN", domain);
      }
    }catch (e){
      print(e);
    }
  }
} 
