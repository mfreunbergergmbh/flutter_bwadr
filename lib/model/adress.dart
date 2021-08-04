class Adress{
  String name = "";
  String number = "";
  String telNumber = "-/-";
  String email = "-/-";

  Adress({required this.name, required this.number, String telNumber="-/-", String email="-/-"}){
    this.telNumber = (telNumber.isEmpty == true) ? "-/-" : telNumber;
    this.email = (email.isEmpty == true) ? "-/-" : email;
    print(email);
    print(telNumber);
  }
}
