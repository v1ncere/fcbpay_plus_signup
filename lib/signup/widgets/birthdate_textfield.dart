import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import 'widgets.dart';

class BirthdateTextfield extends StatelessWidget {
  const BirthdateTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.birthdDateController != current.birthdDateController,
      builder: (context, state) {
        return CustomTextformfield(
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            CustomDateTextFormatter()
          ],
          controller: state.birthdDateController,
          keyboardType: TextInputType.datetime,
          autofocus: true,
          labelText: 'DD/MM/YYYY',
          hintText: 'DD/MM/YYYY',
          suffixIcon: IconButton(
            icon: const Icon(FontAwesomeIcons.calendar),
            iconSize: 18,
            onPressed: () async => await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1930),
              lastDate: DateTime.now(),
            ).then((value) {
              if (context.mounted) {
                context.read<SignupBloc>().add(BirthDateChanged(value ?? DateTime.now()));
              }
            })
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(height: 1.5),
          validator: (value) {
            final regExp = RegExp(r'^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/(19[5-9]\d|20\d{2})$');
            return value?.isEmpty == true
              ? 'date is required'
              : regExp.hasMatch(value!)
                ? null
                : 'invalid date';
          },
          onChanged: (value) => context.read<SignupBloc>().add(BirthDateChanged(DateTime.parse(value))),
        );
      }
    );
  }
}