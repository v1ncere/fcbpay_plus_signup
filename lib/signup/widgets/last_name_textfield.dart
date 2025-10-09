import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import 'custom_textformfield.dart';

class LastNameTextfield extends StatefulWidget {
  const LastNameTextfield({super.key});
  
  @override
  State<LastNameTextfield> createState() => LastNameTextfieldState();
}

class LastNameTextfieldState extends State<LastNameTextfield> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return CustomTextformfield(
          controller: controller,
          keyboardType: TextInputType.name,
          labelText: 'Last Name',
          errorText: state.lastName.displayError?.text(),
          suffixIcon: !state.lastName.isPure 
          ? IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              iconSize: 18,
              onPressed: () {
                controller.clear();
                context.read<SignupBloc>().add(LastNameCleared());
              }
            )
          : null,
          onChanged: (value) => context.read<SignupBloc>().add(LastNameChanged(value))
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