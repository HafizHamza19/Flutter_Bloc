import 'package:flutterblock/validator/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  //getters
  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get email =>
      _email.stream.transform(emailValidatorRegistration);
  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(phoneValidator);
  Stream<String> get password =>
      _password.stream.transform(passwordValidatorRegistration);
  Stream<String> get confirmPassword =>
      _confirmPassword.stream.transform(confirmPasswordValidator);

  //setters
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePhoneNumber => _phoneNumber.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;

  //Validation
  Stream<bool> get isValidate => Rx.combineLatest5(name, email, phoneNumber,
      password, confirmPassword, (a, b, c, d, e) => true);

  void register() {
    print(_name.value);
    print(_email.value);
    print(_phoneNumber.value);
    print(_password.value);
    print(_confirmPassword.value);
  }

  void dispose() {
    _name.close();
    _email.close();
    _phoneNumber.close();
    _password.close();
    _confirmPassword.close();
  }
}
