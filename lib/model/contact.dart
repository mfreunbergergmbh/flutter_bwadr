class Contact{
  String adressNumber = "";
  String firstName = "";
  String lastName = "";
  String email = "-/-";
  String telNumber = "-/-";
  String mobileNumber = "-/-";
  String title = "-/-";
  String pronoun = "-/-";

  Contact({required this.adressNumber,
    String lastName = "-/-", 
    String firstName=" ", 
    String email="-/-", 
    String telNumber="-/-",
    String mobileNumber="-/-",
    String title="-/-",
    String pronoun="-/-"
  }){
    this.telNumber = (telNumber.isEmpty) ? "-/-" : telNumber;
    this.email = (email.isEmpty) ? "-/-" : email;
    this.firstName = (firstName.isEmpty) ? "Ansprechpartner" : firstName;
    this.lastName = (lastName.isEmpty) ? "" : lastName; 
    this.mobileNumber = (mobileNumber.isEmpty) ? "-/-" : mobileNumber;
    this.title = (title.isEmpty) ? "" : (title+" ");
    this.pronoun = (pronoun.isEmpty) ? "" : (pronoun+" ");
  }
}
