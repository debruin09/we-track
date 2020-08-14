import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_track/models/user.dart';
import 'package:we_track/repositories/firestore_service.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    print(email + "  " + password);
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(
      {String username,
      String email,
      String password,
      String type,
      String route}) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirestoreService(uid: result.user.uid).updateUserData(
      email: email,
      password: password,
      type: type,
      route: route,
      uid: result.user.uid,
      username: username,
    );
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  User _userFromFirebase(FirebaseUser firebaseUser) {
    return firebaseUser != null
        ? User(
            uid: firebaseUser.uid,
          )
        : null;
  }

  Future<User> getUser() async {
    final result = await _firebaseAuth
        .currentUser()
        .then((user) => _userFromFirebase(user));
    final User user =
        await FirestoreService(uid: result.uid).getUser(result.uid);
    return user;
  }
}
