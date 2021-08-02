class Adress{
  String name = "";
  String number = "";
  String telNumber = "-/-";
  String email = "-/-";

  Adress({required this.name, required this.number, String telNumber="-/-", String email="-/-"}){
    this.telNumber = telNumber;
    this.email = email;
  }
}
