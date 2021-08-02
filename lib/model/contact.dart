class Contact{
  String adressNumber = "";
  String firstName = "";
  String lastName = "";
  String email = "-/-";
  String telNumber = "-/-";

  Contact({required this.adressNumber, required this.lastName, 
          String firstname=" ", String email="-/-", String telNumber="-/-"
  }){
    this.telNumber = telNumber;
    this.email = email;
    this.firstName = firstName;
  }
}
