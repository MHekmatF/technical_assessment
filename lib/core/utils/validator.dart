class Validator {
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null || val.trim().isEmpty) {
      return 'email is required';
    } else if (!emailRegex.hasMatch(val)) {
      return 'email is not valid';
    } else {
      return null;
    }
  }




  static String? validatePassword(String? val) {
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{8,}$');
    if (val == null || val.isEmpty) {
      return 'password is required';
    } else if (!passwordRegex.hasMatch(val)) {
      return 'password must be at least 8 characters long, contain at least one uppercase letter and one number';
    } else {
      return null;
    }
  }


}
