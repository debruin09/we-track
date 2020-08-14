class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _usernameRegExp = RegExp(
    r'^[a-zA-Z]+$',
  );
  static final RegExp _typeRegExp = RegExp(
    r'^[a-zA-Z]+$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidUsername(String username) {
    return _usernameRegExp.hasMatch(username);
  }

  static isValidType(String type) {
    final newType = type.toLowerCase();
    if (newType == "student") {
      return true;
    } else if (newType == "driver") {
      return true;
    }
    return false;
  }

  static isValidRoute(String route) {
    final newRoute = route.toLowerCase();
    if (newRoute == "route 1") {
      return true;
    }
    if (newRoute == "routte 2") {
      return true;
    }
    if (newRoute == "route 3") {
      return true;
    }
    if (newRoute == "routte 4") {
      return true;
    }
    return false;
  }

  static isValidPassword(String password) {
    // return _passwordRegExp.hasMatch(password);
    return true;
  }
}
