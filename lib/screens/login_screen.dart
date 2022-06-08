import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblock/bloc/login_bloc.dart';
import 'package:flutterblock/cubits/internetCubit.dart';
import 'package:flutterblock/screens/register_screen.dart';
import 'package:flutterblock/theme/colors.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                height: 400,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 15,
                  shadowColor: Colors.blue,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: StreamBuilder(
                              stream: bloc.loginEmail,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                return TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      errorText: snapshot.hasError
                                          ? snapshot.error.toString()
                                          : null,
                                      hintText: "Enter email",
                                      labelText: "Email",
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                  onChanged: (value) {
                                    bloc.changeLoginEmail(value);
                                    print(value);
                                  },
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: StreamBuilder<String>(
                              stream: bloc.loginPassword,
                              builder: (context, snapshot) {
                                return TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: isVisible,
                                  decoration: InputDecoration(
                                      errorText: snapshot.hasError
                                          ? snapshot.error.toString()
                                          : null,
                                      hintText: "Enter Password",
                                      labelText: "Password",
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isVisible = !isVisible;
                                            });
                                          },
                                          icon: isVisible
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility))),
                                  onChanged: (value) =>
                                      bloc.changeLoginPassword(value),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 200,
                          child: StreamBuilder<bool>(
                              stream: bloc.isValid,
                              builder: (context, snapshot) {
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: snapshot.hasError ||
                                                !snapshot.hasData
                                            ? FColors.disableColor
                                            : FColors.primaryColor,
                                        elevation: 10,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                    onPressed: snapshot.hasError
                                        ? null
                                        : () {
                                            //TODO : LOGIN BUTTON
                                            print("LOGIN API CALL");
                                            bloc.login();
                                          },
                                    child: const Text("Login"));
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Need an account?",
                              style: TextStyle(color: FColors.txtColor)),
                          const WidgetSpan(
                              child: SizedBox(
                            width: 5,
                          )),
                          TextSpan(
                            style: TextStyle(
                                color: FColors.txtColor,
                                fontWeight: FontWeight.bold),
                            text: "Register here!",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Single tapped.
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                          ),
                        ])),

                        //bloc for both ui and background

                        /*  BlocConsumer<InternetBloc, InternetState>(
                            listener: (context, state) {
                          if (state is InternetGainedState) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Connected!"),
                              backgroundColor: Colors.green,
                            ));
                          } else if (state is InternetLostState) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Connection Lost"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }, builder: (context, state) {
                          if (state is InternetLostState) {
                            return const Text("Internet Lost");
                          } else if (state is InternetGainedState) {
                            return const Text("Internet Connected");
                          } else {
                            return const Text("Loading...");
                          }
                        }),*/
                        //Cubits for both ui and background

                        /*BlocConsumer<InternetCubit, InternetStateCubit>(
                            listener: (context, state) {
                          if (state == InternetStateCubit.gained) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Connected!"),
                              backgroundColor: Colors.green,
                            ));
                          } else if (state == InternetStateCubit.lost) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Connection Lost"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }, builder: (context, state) {
                          if (state == InternetStateCubit.lost) {
                            return const Text("Internet Lost");
                          } else if (state == InternetStateCubit.gained) {
                            return const Text("Internet Connected");
                          } else {
                            return const Text("Loading...");
                          }
                        }),*/
                        //only for background if need only in UI so use BlocBuilder

                        /*BlocListener<InternetBloc, InternetState>(
                          listener: (context, state) {
                            if (state is InternetGainedState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Connected!"),
                                backgroundColor: Colors.green,
                              ));
                            } else if (state is InternetLostState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Connection Lost"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: Container(),
                        ),*/
                        //Cubits
                        BlocListener<InternetCubit, InternetStateCubit>(
                          listener: (context, state) {
                            if (state == InternetStateCubit.gained) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Connected!"),
                                backgroundColor: Colors.green,
                              ));
                            } else if (state == InternetStateCubit.lost) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Connection Lost"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: Container(),
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
