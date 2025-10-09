import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(ColorString.eucalyptus),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
          ),
          onPressed: () => context.read<SignupBloc>().add(SignupSubmitted()),
          child: Text(
            'Submit',
            style: TextStyle(color: ColorString.white)
          )
        );
      }
    );
  }
}