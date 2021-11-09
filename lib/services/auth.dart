import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signUpWithEmailAndPassword(
      String email, String password, String username) async {
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(username);
      await user.reload();

      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("The password provided is too weak.");
      } else if (e.code == "email-already-in-use") {
        print("An account already exists with that email.");
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that email");
      } else if (e.code == "wrong-passsword") {
        print("Wrong password provided for that account");
      }
    }
    return user;
  }
}
