import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterblock/bloc/register_bloc.dart';
import 'package:flutterblock/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisiblePassword = true;
  bool isVisibleConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Card(
            shadowColor: FColors.primaryColor,
            elevation: 15,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _text("Registration"),
                  _spacing(30, 0),
                  StreamBuilder<String>(
                      stream: bloc.name,
                      builder: (context, snapshot) {
                        return _textField("Name", TextInputType.emailAddress,
                            bloc.changeName, snapshot);
                      }),
                  _spacing(30, 0),
                  StreamBuilder<String>(
                      stream: bloc.email,
                      builder: (context, snapshot) {
                        return _textField("Email", TextInputType.emailAddress,
                            bloc.changeEmail, snapshot);
                      }),
                  _spacing(30, 0),
                  StreamBuilder<String>(
                      stream: bloc.phoneNumber,
                      builder: (context, snapshot) {
                        return _textField("Phone number", TextInputType.number,
                            bloc.changePhoneNumber, snapshot);
                      }),
                  _spacing(30, 0),
                  StreamBuilder<String>(
                      stream: bloc.password,
                      builder: (context, snapshot) {
                        return TextField(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: isVisiblePassword,
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisiblePassword = !isVisiblePassword;
                                    });
                                  },
                                  icon: isVisiblePassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              hintText: "Password",
                              labelText: "Password",
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onChanged: (value) => bloc.changePassword(value),
                        );
                      }),
                  _spacing(30, 0),
                  StreamBuilder<String>(
                      stream: bloc.confirmPassword,
                      builder: (context, snapshot) {
                        return TextField(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: isVisibleConfirmPassword,
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisibleConfirmPassword =
                                          !isVisibleConfirmPassword;
                                    });
                                  },
                                  icon: isVisibleConfirmPassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              hintText: "Confirm Password",
                              labelText: "Confirm Password",
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onChanged: (value) =>
                              bloc.changeConfirmPassword(value),
                        );
                      }),
                  _spacing(30, 0),
                  _button("Register"),
                  _spacing(30, 0),
                  _txtSpan([
                    TextSpan(
                        text: "Do you have already an account?",
                        style: TextStyle(color: FColors.txtColor)),
                    const WidgetSpan(child: SizedBox(width: 5)),
                    TextSpan(
                        style: TextStyle(
                            color: FColors.txtColor,
                            fontWeight: FontWeight.bold),
                        text: "Login here!",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          })
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _textField(String hint, TextInputType textInputType, dynamic blocValue,
      AsyncSnapshot<String> snapshot) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return TextField(
      keyboardType: textInputType,
      decoration: InputDecoration(
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
          hintText: hint,
          labelText: hint,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      onChanged: (value) {
        blocValue(value);
        print("Hello " + bloc.isValidate.toString());
      },
    );
  }

  Widget _spacing(double h, double w) {
    return SizedBox(height: h, width: w);
  }

  Widget _text(String txt) {
    return Text(
      txt,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
    );
  }

  Widget _txtSpan(List<InlineSpan> children) {
    return Text.rich(TextSpan(children: children));
  }

  Widget _button(String txt) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
    return SizedBox(
      width: 200,
      child: StreamBuilder<bool>(
          stream: bloc.isValidate,
          builder: (context, snapshot) {
            return ElevatedButton(
              onPressed: snapshot.hasError
                  ? null
                  : () {
                      //TODO: REGISTRATION API
                      bloc.register();
                    },
              child: Text(txt),
              style: ElevatedButton.styleFrom(
                  primary: snapshot.hasError || !snapshot.hasData
                      ? FColors.disableColor
                      : FColors.primaryColor,
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            );
          }),
    );
  }
}
