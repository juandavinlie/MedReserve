import 'package:cloud_firestore/cloud_firestore.dart';

class Applicant {

  String applicantId;
  int phoneNumber;
  String email;
  String name;
  int age;
  String gender;
  List symptoms;
  bool covidPositive;
  Timestamp createdAt;

  Applicant({ this.applicantId, this.email, this.phoneNumber, this.name, this.age, this.gender, this.symptoms, this.covidPositive, this.createdAt });
}