import 'package:firebase_auth/firebase_auth.dart';
import 'package:medreserve/models/hospital.dart';
import 'package:medreserve/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user stream
  Stream<Hospital> get hospital {
    return _auth.onAuthStateChanged
    .map((FirebaseUser user) => _hospitalFromFirebaseUser(user));
  }

  Hospital _hospitalFromFirebaseUser(FirebaseUser user) {
    return user != null ? Hospital(uniqueId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _hospitalFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password, String name, int capacity) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null) {
        Hospital newHospital = Hospital(uniqueId: user.uid, name: name, capacity: capacity);
        await DatabaseService(hospitalId: user.uid).addHospital(newHospital);
      }
      return _hospitalFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}