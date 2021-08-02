import 'package:bwadr/model/contact.dart';

class ContactData {

  static List<Contact> contacts = [];

  static Future<void> getContacts({int number=0}) async {
    contacts = await Future.delayed(Duration(seconds: 5), (){
      return <Contact> [
        Contact(adressNumber: "1000", lastName: "Wippel"),
        Contact(adressNumber: "1000", lastName: "Hoerhan"),
        Contact(adressNumber: "1001", lastName: "Schrey"),
        Contact(adressNumber: "1002", lastName: "Hoeller"),
      ];
    }); 
  }
}
