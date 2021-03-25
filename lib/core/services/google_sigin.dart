import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseGoogleAuthServices {
  // FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();
  Future<User> signIn() async {
    try {
      await Firebase.initializeApp();

      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User user = authResult.user;

      if (user == null) return null;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;

      assert(user.uid == currentUser.uid);

      print("User Name: ${user.displayName}");
      print("User Email ${user.email}");

      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signout() async {
    try {
      await Firebase.initializeApp();

      final GoogleSignIn _googleSignIn = GoogleSignIn();

      await _googleSignIn.signOut();
    } catch (e) {
      throw e;
    }
  }
}
