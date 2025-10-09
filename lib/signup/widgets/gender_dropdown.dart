import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class GenderDropdown extends StatelessWidget {
  const GenderDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {
        return DropdownButtonFormField(
          isDense: true,
          value: state.gender.value,
          decoration: InputDecoration(
            labelText: 'Gender',
            labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            )
          ),
          onChanged: (value) => context.read<SignupBloc>().add(GenderChanged(value!)),
          validator: (value) {
            return value == null
            ? 'Please select an option.'
            : null;
          },
          items: genderStringList.map((item) {
            return DropdownMenuItem<String> (
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.black54
                )
              )
            );
          }).toList()
        );
      }
    );
  }
}