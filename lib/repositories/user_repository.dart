import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_track/models/user.dart';
import 'package:we_track/repositories/firestore_service.dart';

/// This is the Firebase authentication implementation
class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  /// This will login the users with the email and password details
  Future<void> signInWithCredentials(String email, String password) {
    print(email + "  " + password);
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /// This allows the users to signup
  Future<void> signUp(
      {String username,
      String email,
      String stop,
      String password,
      String type,
      String route}) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    /// Once the user is registered or authenticated their data will be added to the database
    await FirestoreService(uid: result.user.uid).updateUserData(
      email: email,
      password: password,
      type: type ?? "",
      route: route ?? "",
      stop: stop ?? "",
      uid: result.user.uid,
      username: username,
    );
  }

  /// Reset the users password by sending a email to the user
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// This will log the user out
  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  /// This will check the users authentication state whether the user is signed in or not
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  /// convert a firebase user to our user model
  User _userFromFirebase(FirebaseUser firebaseUser) {
    return firebaseUser != null
        ? User(
            uid: firebaseUser.uid,
          )
        : null;
  }

  /// This will get the user from firebase
  Future<User> getUser() async {
    final result = await _firebaseAuth
        .currentUser()
        .then((user) => _userFromFirebase(user));
    final User user =
        await FirestoreService(uid: result.uid).getUser(result.uid);
    return user;
  }
}
