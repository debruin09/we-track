/// This is the validator that checks the users input on the register and login screen
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
  static final RegExp _driverCodeRegExp = RegExp(
    r'^[0-9]{4}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidUsername(String username) {
    return _usernameRegExp.hasMatch(username);
  }

  /// Driver codes: [1342, 3674, 9006, 6348]
  static isValidDriverCode(String code) {
    if (code == '1342') {
      return true;
    } else if (code == "3674") {
      return true;
    } else if (code == "9006") {
      return true;
    } else if (code == "6348") {
      return true;
    }
    return false;
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
    if (newRoute == "route 2") {
      return true;
    }
    if (newRoute == "route 3") {
      return true;
    }
    if (newRoute == "route 4") {
      return true;
    }
    return false;
  }

  static isValidPassword(String password) {
    // return _passwordRegExp.hasMatch(password);
    return true;
  }
}
