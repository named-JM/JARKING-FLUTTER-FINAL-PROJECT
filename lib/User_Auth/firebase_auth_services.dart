import 'package:final_project_for_flutter_by_jarling/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

///THIS IS FOR AUTHENTICATION LOGIC
///This code defines a FirebaseAuthService class responsible
///for interacting with Firebase Authentication in a Flutter application.
class FirebaseAuthService {
  //AUTH INSTANCE FOR REFERENCING TO FIREBASE DATABASE
  FirebaseAuth _auth = FirebaseAuth.instance;

  ///this is a methof in the FirebaseAuthService class that attempts to sign up a user with the provided email and password.
  ///It returns a Future<User?> which will contain the user if the sign-up is successful.
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    //creating for exception error
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email add is already in use');
      } else {
        showToast(message: 'An error occured: ${e.code}');
      }
    }
    return null;
  }

  ///This method updates the display name of a user with a provided username.
  ///It catches any errors that might occur during the update process and prints an error message to the console.
  Future<void> updateUsername(User user, String username) async {
    try {
      await user.updateDisplayName(username);
    } catch (e) {
      print("Error updating username: $e");
    }
  }

  ///This method attempts to sign in a user with the provided email and password.
//It returns a Future<User?> which will contain the user if the sign-in is successful.
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password');
      } else {
        showToast(message: 'An error occured: ${e.code}');
      }
    }
    return null;
  }
}
/*The FirebaseAuthService class encapsulates authentication-related functionality using Firebase.
It provides methods for user sign-up, updating usernames, and user sign-in.
Exception handling is included to manage different scenarios, and toast messages are displayed to inform the user of the outcome.  */