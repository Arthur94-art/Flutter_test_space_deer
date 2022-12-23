import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/ui/auth_screen.dart';
import 'package:test_space_deer/ui/home.dart';

import '../bloc/login/check_user_exist/check_logged_user_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<CheckLoggedUserBloc>().add(IsUserLoggedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CheckLoggedUserBloc, CheckLoggedUserState>(
        builder: (context, state) {
          if (state is UserInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoggedState) {
            return const HomePage();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
