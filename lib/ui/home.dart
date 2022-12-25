import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/bloc/user_data/user_data_bloc.dart';
import 'package:test_space_deer/ui/widgets/custom_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<UserDataBloc>().add(FetchUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is FetchUserInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchUserLoadedState) {
            return ListView.builder(
              itemCount: state.userModel.length,
              itemBuilder: (context, index) {
                return CustomCardWidget(
                  uuid: state.userModel[index].uid as String,
                  creationTime: state.userModel[index].creationTime as DateTime,
                  lastSignInTime:
                      state.userModel[index].lastSignInTime as DateTime,
                  notificationToken:
                      state.userModel[index].notificationToken ?? 'sdf',
                );
              },
            );
          }
          if (state is FetchUserFailureState) {
            return Text(state.errorMessage);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
