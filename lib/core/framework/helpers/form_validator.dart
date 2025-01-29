class FormValidator {
  static isEmailValid(String? value) {
    final RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (value!.isEmpty) {
      return 'Enter mail';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid mail format';
    }
  }

  static isNameValid(String? value) {
    RegExp regExp = RegExp(r'^[A-Za-z]+$');

    if (value!.isEmpty) {
      return 'Required field';
    } else if (!regExp.hasMatch(value) || value.length < 2) {
      return 'Enter a valid name';
    }
  }

  static isPhoneNumberValid(String? value) {
    RegExp regExp = RegExp(r'^[0-9]+$');

    if (value!.isEmpty) {
      return 'Required field';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    } else if (value.length < 11) {
      return 'Phone number is too short';
    } else if (value.length > 11) {
      return 'Phone number is too long';
    }
  }

  static isPasswordValid(String? value) {
    if (value!.isEmpty) {
      return 'Required field';
    } else if (value.length < 7) {
      return 'Password must be greater than 6 characters';
    }
  }

  static passwordMatch(String? password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Required field';
    } else if (password != confirmPassword) {
      return 'Passwords don\'t  match';
    }
  }

  static isEmpty(String? value) {
    if (value!.isEmpty) {
      return 'Required field';
    }
  }

  static bool validateLength(String value, int length) {
    if (value.length >= length) {
      return true;
    }
    return false;
  }

  static bool validateUppercase(String value) {
    RegExp regExp = RegExp(r'[A-Z]');
    if (regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool validateLowerCase(String value) {
    RegExp regExp = RegExp(r'[a-z]');
    if (regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool validateSpecialCharacter(String value) {
    RegExp regExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bvnValidator(String? value) {
    if (value!.isEmpty) {
      return 'Required field';
    } else if (value.length != 11) {
      return 'Incorrect BVN';
    }
  }

  static amountValidator(int amount, int? balance) {
    if (amount < 100) {
      return 'Amount cannot be less than ₦100';
    } else if (balance != null) {
      if (amount >= balance) {
        return 'Amount is equal or bigger than available balance';
      }
    }
  }

  static receiveAmountValidator(int amount) {
    if (amount == 0) {
      return 'Amount cannot be ₦0';
    }
  }

  static accountNumValidator(String? value) {
    if (value!.isEmpty) {
      return 'Required field';
    } else if (value.length != 10) {
      return 'Must be 10 digits';
    }
  }
}
