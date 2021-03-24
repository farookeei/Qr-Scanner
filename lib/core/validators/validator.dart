class Validators {
  String _normalcheck(String _val) {
    if (_val == null) {
      return 'Please fill the field';
    }
    if (_val.isEmpty) {
      return 'Please fill the field';
    }
    return null;
  }

  String nameValidator(String _val) => _normalcheck(_val);

  String emailValidator(String email) {
    if (_normalcheck(email) != null) {
      return 'Please fill the field';
    }

    bool _isReExpresionResult = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (!_isReExpresionResult) {
      return 'Enter correct Email Adress';
    }
    return null;
  }

  String phoneNumberCheck(String _val) {
    if (_normalcheck(_val) != null) {
      return 'Please fill the field';
    }
    if (double.tryParse(_val) == null) {
      return 'Enter Correct Mobile Number';
    }

    if (_val.length != 10) {
      return 'Enter Correct Mobile Number';
    }

    return null;
  }

  String passwordValidator(String _val) {
    if (_normalcheck(_val) != null) {
      return 'Please fill the field';
    }

    if (_val.length <= 5) {
      return 'Password must be greater than 6 length';
    }
    return null;
  }
}
