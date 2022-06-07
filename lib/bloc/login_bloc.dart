import 'package:flutterblock/validator/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  //Getter

  Stream<String> get loginEmail => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginPassword =>
      _loginPassword.stream.transform(passwordValidator);

  //Setter
  Function(String) get changeLoginEmail => _loginEmail.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;

  //validation
  Stream<bool> get isValid => Rx.combineLatest2(
      loginEmail, loginPassword, (loginEmail, loginPassword) => true);

  void login() {
    print(_loginEmail.value);
    print(_loginPassword.value);
  }

  void dispose() {
    _loginEmail.close();
    _loginPassword.close();
  }
}
