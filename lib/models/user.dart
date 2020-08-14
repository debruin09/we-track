// This is the user model class
class User {
  String email;
  String password;
  String username;
  String uid;
  String route;
  String type;
  User({
    this.email,
    this.password,
    this.username,
    this.uid,
    this.route,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'uid': uid,
      'route': route,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'User(email: $email, password: $password, username: $username, uid: $uid, route: $route, type: $type)';
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      email: map['email'],
      password: map['password'],
      username: map['username'],
      uid: map['uid'],
      route: map['route'],
      type: map['type'],
    );
  }
}
