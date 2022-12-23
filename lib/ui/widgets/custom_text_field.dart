import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_space_deer/bloc/login/auth/auth_bloc.dart';
import 'package:test_space_deer/utils/input_formatter.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController phoneController;
  const CustomTextField({required this.phoneController, super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

bool _isShowButton = true;
bool _isSwohTextField = true;
bool _isShowLoading = false;
bool _phoneNumberLength = false;

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ShowButtonState) {
          log('${state.isShowButton}');
          _isShowButton = state.isShowButton;
          _isSwohTextField = state.isShowButton;
          _isShowLoading = !state.isShowButton;
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              enabled: _isSwohTextField,
              inputFormatters: [InputFormatter.phoneFormatter],
              onChanged: (value) {
                _phoneNumberLength = widget.phoneController.text.length == 17;
                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              controller: widget.phoneController,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      )),
                  onPressed: _isShowButton && _phoneNumberLength
                      ? () {
                          context.read<AuthBloc>()
                            ..add(AuthRequestEvent(widget.phoneController.text))
                            ..add(ShowButtonEvent(false));
                        }
                      : null,
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 20, letterSpacing: 1),
                  )),
            ),
            const SizedBox(height: 20),
            Text(_isShowLoading ? 'Sending...' : '')
          ],
        ),
      ),
    );
  }
}
