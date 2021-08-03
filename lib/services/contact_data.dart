import 'package:bwadr/model/contact.dart';

class ContactData {

  static List<Contact> contacts = [];
  static List<Contact> contactList({String number="0"}){
    return contacts.where((index)=> index.adressNumber == number).toList();
  }

  static Future<void> getContacts({String number="0"}) async {
    if (contacts.where((index) => index.adressNumber == number ).length > 0) {
      return; 
    }
    List<Contact> newContacts = await Future.delayed(Duration(seconds: 5), (){
      return <Contact> [
        Contact(adressNumber: "1000", lastName: "Wippel", telNumber: "+43 1234", email: "wippel@mail.com"),
        Contact(adressNumber: "1000", lastName: "Tobias", telNumber: "+43 676 82537146"),
        Contact(adressNumber: "1000", lastName: "Freunberger", telNumber: "+43 664 3922936", email: "bernhard@freunberger.com"),
        Contact(adressNumber: "1000", lastName: "another name 2"),
        Contact(adressNumber: "1000", lastName: "Hoerhan"),
        Contact(adressNumber: "1001", lastName: "Schrey"),
        Contact(adressNumber: "1002", lastName: "Hoeller"),
      ];
    }); 

    contacts.addAll(newContacts);
  }
}
