import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/bloc/login/auth/auth_bloc.dart';
import 'package:test_space_deer/bloc/login/check_user_exist/check_logged_user_bloc.dart';
import 'package:test_space_deer/bloc/login/sent_code/sent_code_bloc.dart';
import 'package:test_space_deer/bloc/user_data/user_data_bloc.dart';
import 'package:test_space_deer/ui/splach_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => CheckLoggedUserBloc()),
        BlocProvider(create: (context) => SendOTPBloc()),
        BlocProvider(create: (context) => UserDataBloc()),
      ],
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
