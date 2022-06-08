import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblock/bloc/internetBloc/internetbloc.dart';
import 'package:flutterblock/bloc/login_bloc.dart';
import 'package:flutterblock/bloc/register_bloc.dart';
import 'package:flutterblock/cubits/internetCubit.dart';
import 'package:flutterblock/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBloc>(create: (context) => RegisterBloc())
      ],
      //for single bloc
      child: /*BlocProvider(
        create: (context) => InternetBloc(),*/
          MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(create: (context) => InternetCubit()),
          BlocProvider<InternetBloc>(create: (context) => InternetBloc())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
