import 'package:medreserve/models/applicant.dart';
import 'package:medreserve/models/hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medreserve/models/localhospital.dart';
import 'package:medreserve/services/auth.dart';

class DatabaseService {

  final String hospitalId; 

  DatabaseService({ this.hospitalId });

  final CollectionReference hospitalCollection = Firestore.instance.collection('hospitals');
  final Query applicantCollection = Firestore.instance.collection('applicants').orderBy('createdAt');

  List<Applicant> _applicantListFromQuerySnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.documents.map(
      (doc) {
        return Applicant(
          applicantId: doc.documentID,
          phoneNumber: doc['phone_number'],
          name: doc['name'],
          age: doc['age'],
          gender: doc['gender'],
          symptoms: doc['symptoms'],
          covidPositive: doc['covid19_positive'],
          createdAt: doc['createdAt'],
          email: doc['email']
        );
      }).toList();
    } catch(e) {
      print(e);
      return null;
    }
  }

  LocalHospital _localHospitalFromDocumentSnapshot(DocumentSnapshot snapshot) {
    try {
      String name = snapshot.data['name'];
      int capacity = snapshot.data['capacity'];
      return LocalHospital(uniqueId: snapshot.documentID, name: name, capacity: capacity);
    } catch(e) {
      AuthService().signOut();
      return null;
    }
  }

  Stream<List<Applicant>> get applicants {
    return applicantCollection.where('hospitals_applied_to', arrayContains: hospitalId).snapshots().map(_applicantListFromQuerySnapshot);
  } 
  
  Stream<List<Applicant>> get acceptedApplicants {
    return Firestore.instance.collection('hospitals').document(hospitalId).collection('accepted_applicants').orderBy('createdAt').snapshots().map(_applicantListFromQuerySnapshot);
  } 

  Stream<LocalHospital> get localHospital {
    return hospitalCollection.document(hospitalId).snapshots().map(_localHospitalFromDocumentSnapshot);
  }

  // call when a new user is registered
  Future addHospital(Hospital hospital) async {
    return await hospitalCollection.document(hospitalId).setData({
      'name': hospital.name,
      'capacity': hospital.capacity
    });
  }

  Future moveApplicantToAccepted(Applicant applicant) async {
    applicantCollection.reference().document(applicant.applicantId).delete();
    hospitalCollection.document(hospitalId).updateData(
      {
        'capacity': FieldValue.increment(-1)
      }
    );
    return await hospitalCollection.document(hospitalId).collection('accepted_applicants').document(applicant.applicantId).setData({
      'name': applicant.name,
      'age': applicant.age,
      'gender': applicant.gender,
      'symptoms': applicant.symptoms,
      'covid19_positive': applicant.covidPositive,
      'createdAt': applicant.createdAt,
      'email': applicant.email,
      'phone_number': applicant.phoneNumber
    });
  }

  void deleteApplicantFromAccepted(Applicant applicant) {
    hospitalCollection.document(hospitalId).collection('accepted_applicants').document(applicant.applicantId).delete();
    hospitalCollection.document(hospitalId).updateData(
      {
        'capacity': FieldValue.increment(1)
      }
    );
  }
}