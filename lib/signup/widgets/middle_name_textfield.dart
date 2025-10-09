import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import 'widgets.dart';

class MiddleNameTextfield extends StatefulWidget {
  const MiddleNameTextfield({super.key});
  
  @override
  State<MiddleNameTextfield> createState() => MiddleNameTextfieldState(); 
}

class MiddleNameTextfieldState extends State<MiddleNameTextfield> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.middleName != current.middleName,
      builder: (context, state) {
        return CustomTextformfield(
          controller: controller,
          keyboardType: TextInputType.name,
          labelText: 'Middle Name',
          errorText: state.middleName.displayError?.text(),
          suffixIcon: !state.middleName.isPure
          ? IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              iconSize: 18,
              onPressed: () {
                controller.clear();
                context.read<SignupBloc>().add(MiddleNameCleared());
              }
            )
          : null,
          onChanged: (value) => context.read<SignupBloc>().add(MiddleNameChanged(value)),
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