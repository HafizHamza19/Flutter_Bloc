import 'dart:async';

mixin Validators {
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty) {
      return sink.addError("Please Enter Email");
    }
    if (email.length < 8) {
      return sink.addError("Email is too short");
    } else {
      sink.add(email);
    }
  });
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isEmpty) {
      return sink.addError("Please Enter Password");
    }
    if (password.length < 8) {
      return sink.addError("Password is too short");
    } else {
      sink.add(password);
    }
  });

  var emailValidatorRegistration =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty) {
      return sink.addError("Please Enter Email");
    }
    if (email.length < 8) {
      return sink.addError("Email is too short");
    } else {
      sink.add(email);
    }
  });

  var nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isEmpty) {
      return sink.addError("Please enter Name");
    } else {
      sink.add(name);
    }
  });
  var phoneValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.isEmpty) {
      return sink.addError("Please enter number");
    }
    if (phone.length != 11) {
      return sink.addError("Number is not valid");
    } else {
      sink.add(phone);
    }
  });

  var passwordValidatorRegistration =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.isEmpty) {
      return sink.addError("Please Enter Password");
    }
    if (password.length < 8) {
      return sink.addError("Password is too short");
    } else {
      sink.add(password);
    }
  });
  var confirmPasswordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (confirmPassword, sink) {
    if (confirmPassword.isEmpty) {
      return sink.addError("Please Enter password");
    }
    if (confirmPassword.length < 8) {
      return sink.addError("Password is too short");
    } else {
      sink.add(confirmPassword);
    }
  });
}
