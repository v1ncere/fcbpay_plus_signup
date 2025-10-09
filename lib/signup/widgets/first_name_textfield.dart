import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import 'widgets.dart';

class FirstNameTextfield extends StatefulWidget {
  const FirstNameTextfield({super.key});
  
  @override
  State<FirstNameTextfield> createState() => FirstNameTextfieldState();
}

class FirstNameTextfieldState extends State<FirstNameTextfield> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return CustomTextformfield(
          controller: controller,
          keyboardType: TextInputType.name,
          labelText: 'First Name',
          errorText: state.firstName.displayError?.text(),
          suffixIcon: !state.firstName.isPure
          ? IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              iconSize: 18,
              onPressed: () {
                controller.clear();
                context.read<SignupBloc>().add(FirstNameCleared());
              }
            )
          : null,
          onChanged: (value) => context.read<SignupBloc>().add(FirstNameChanged(value))
        );
      }
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}