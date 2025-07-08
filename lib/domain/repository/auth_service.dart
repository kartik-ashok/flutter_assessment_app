import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assessment_app/localStorage/app_prefrence.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up (Register)
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // // Sign in (Login)
  // Future<String?> signIn(String email, String password) async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     return null;
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
  Future<String?> signIn(String email, String password) async {
    try {
      // Sign in the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      String? token = await user?.getIdToken();

      // Print user info
      print('UID: ${user?.uid}');
      print('Email: ${user?.email}');
      print('Display Name: ${user?.displayName}');
      print('Phone Number: ${user?.phoneNumber}');
      print('Photo URL: ${user?.photoURL}');
      print('Token: $token');

      // Save to SharedPreferences using your AppPreferences class
      await AppPreferences.setUid(user?.uid);
      await AppPreferences.setEmail(user?.email);
      await AppPreferences.setToken(token);

      return null; // success
    } catch (e) {
      return e.toString(); // error
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }


  
}
