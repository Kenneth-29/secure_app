class Validation {
  // checks if name is empty
  static String? name(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name can\'t be empty';
    }
    return null;
  }

  // checks if the email provided has email features and if its empty
  static String? email(String? email) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email == null || email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }
    return null;
  }

  // checks the password for the folowing:
  //  -has atleast one upperCase
  //  -has atleast one lowerCase
  //  -has atleast one digit
  //  - has atleast one special character
  //  - has a lenght of 8 characters
  //  - if the password is empty
  static String? password(String? password) {
    RegExp passRegExp =
        RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");

    RegExp oneUpper = RegExp(r"(?=.*[A-Z])");
    RegExp oneLower = RegExp(r"(?=.*[a-z])");
    RegExp oneDigi = RegExp(r"(?=.*?[0-9])");
    RegExp oneSpec = RegExp(r"(?=.*?[!@#\$&*~])");
    RegExp l8 = RegExp(r".{8,}");

    if (password == null || password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (!l8.hasMatch(password)) {
      return 'Enter a password with a length of at least 8';
    } else if (!oneUpper.hasMatch(password)) {
      return 'Your password must contain at least 1 upper case';
    } else if (!oneLower.hasMatch(password)) {
      return 'Your password must contain at least 1 lower case';
    } else if (!oneDigi.hasMatch(password)) {
      return 'Your password must contain at least 1 number';
    } else if (!oneSpec.hasMatch(password)) {
      return 'Your password must contain at least one special character';
    } else if (!passRegExp.hasMatch(password)) {
      return 'Enter valid password';
    }
    return null;
  }
}

// r'^
//   (?=.*[A-Z])        should contain at least one upper case
//   (?=.*[a-z])        should contain at least one lower case
//   (?=.*?[0-9])       should contain at least one digit
//   (?=.*?[!@#\$&*~])  should contain at least one Special character
//   .{8,}              Must be at least 8 characters in length  
// $