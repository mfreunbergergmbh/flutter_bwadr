class Contact{
  String adressNumber = "";
  String firstName = "";
  String lastName = "";
  String email = "-/-";
  String telNumber = "-/-";

  Contact({required this.adressNumber,  String lastName = "-/-", 
          String firstName=" ", String email="-/-", String telNumber="-/-"
  }){
    this.telNumber = (telNumber.isEmpty) ? "-/-" : telNumber;
    this.email = (email.isEmpty) ? "-/-" : email;
    this.firstName = (firstName.isEmpty) ? "Ansprechpartner" : firstName;
    this.lastName = (lastName.isEmpty) ? "" : lastName; 
  }
}
