import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import 'widgets.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});
  
  @override
  State<PasswordTextField> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password 
      || previous.obscurePassword != current.obscurePassword,
      builder: (context, state) {
        final strength = _calculateStrength(state.password.value);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextformfield(
              controller: controller,
              keyboardType: TextInputType.visiblePassword,
              obscureText: state.obscurePassword,
              labelText: 'Password',
              suffixIcon: state.password.isPure ? null : _buildSuffixIcons(context, state),
              onChanged: (value) => context.read<SignupBloc>().add(PasswordChanged(value)),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(4, (index) {
                bool active = index < strength;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 4,
                    decoration: BoxDecoration(
                      color: active ? _getStrengthColor(strength) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    )
                  )
                );
              })
            ),
            const SizedBox(height: 4),
            Text(
              _getStrengthLabel(strength),
              style: TextStyle(
                color: _getStrengthColor(strength),
                fontWeight: FontWeight.bold,
              )
            )
          ]
        );
      }
    );
  }

  //** UTILITY METHODS */
  Widget _buildSuffixIcons(BuildContext context, SignupState state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: state.obscurePassword 
          ? const Icon(FontAwesomeIcons.eye) 
          : const Icon(FontAwesomeIcons.eyeSlash),
          iconSize: 18,
          onPressed: () => context.read<SignupBloc>().add(PasswordObscured()),
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.xmark),
          iconSize: 18,
          onPressed: () {
            controller.clear();
            context.read<SignupBloc>().add(PasswordCleared());
          }
        )
      ]
    );
  }

  int _calculateStrength(String pass) {
    int strength = 0;

    if (pass.length >= 6) strength++; // length check
    if (pass.contains(RegExp(r'[A-Z]'))) strength++; // uppercase
    if (pass.contains(RegExp(r'[0-9]'))) strength++; // number
    if (pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++; // special char

    return strength; // returns 0-4
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStrengthLabel(int strength) {
    switch (strength) {
      case 0:
        return "";
      case 1:
        return "Weak";
      case 2:
        return "Fair";
      case 3:
        return "Good";
      case 4:
        return "Strong";
      default:
        return "";
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}