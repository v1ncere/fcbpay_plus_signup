import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widgets/widgets.dart';

class PasswordView extends StatelessWidget {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            color: ColorString.jewel,
            fontWeight: FontWeight.w700,
            fontSize: 18
          )
        ),
        SizedBox(height: 5),
        PasswordTextField(),
        SizedBox(height: 10),
        ConfirmPasswordTextField(),
      ]
    );
  }
}