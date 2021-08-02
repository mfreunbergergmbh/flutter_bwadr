import 'package:bwadr/model/adress.dart';

class AdressData {

  static List<Adress> adresses = [];

  static Future<void> getAdresses() async {
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
