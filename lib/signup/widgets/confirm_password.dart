import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import 'widgets.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({super.key});
  
  @override
  State<ConfirmPasswordTextField> createState() => ConfirmPasswordTextFieldState();
}

class ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  final TextEditingController controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.confirmPassword != current.confirmPassword
      || previous.password != current.password
      || previous.obscureConfirmPassword != current.obscureConfirmPassword,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextformfield(
              controller: controller,
              obscureText: state.obscureConfirmPassword,
              keyboardType: TextInputType.visiblePassword,
              labelText: 'Confirm Password',
              errorText: state.confirmPassword.displayError?.text(),
              suffixIcon: !state.confirmPassword.isPure ? _suffixIcons(context, state) : null,
              onChanged: (value) => context.read<SignupBloc>().add(ConfirmPasswordChanged(confirmPassword: value, password: state.password.value)),
            )
          ]
        );
      }
    );
  }

  //** UTILITY METHODS */
  Widget _suffixIcons(BuildContext context, SignupState state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: state.obscureConfirmPassword
          ? const Icon(FontAwesomeIcons.eye)
          : const Icon(FontAwesomeIcons.eyeSlash),
          iconSize: 18,
          onPressed: () => context.read<SignupBloc>().add(ConfirmPasswordObscured()),
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.xmark),
          iconSize: 18,
          onPressed: () {
            controller.clear();
            context.read<SignupBloc>().add(ConfirmedPasswordCleared());
          }
        )
      ]
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}