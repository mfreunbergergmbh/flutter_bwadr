import 'package:bwadr/model/adress.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:bwadr/database/database.dart';

class AdressData {
  static List<Adress> adresses = [];

  static Adress getAdress(String number){
    for (Adress adress in adresses){
      if (adress.number == number) return adress;
    }
    return Adress(name: "Nicht gefunden", number: "nan");
  }

  static Future<void> getAdresses() async {
    Map<String, dynamic?> decoded = await DataBase.getAdresses();
    try{
      List loadedAdresses = decoded['ADRESSLISTE']["ADRESSE"];
      for(dynamic adress in loadedAdresses){
        adresses.add(Adress(number: adress['ADR_2_8'], name: adress['ADR_20_30'], telNumber: adress['ADR_2332_20'], email: adress['ADR_1330_60']));
      }
    }catch(e){
      print(e);
    }
  }
}
