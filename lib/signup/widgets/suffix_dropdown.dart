import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class SuffixDropdown extends StatelessWidget {
  const SuffixDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.suffixName != current.suffixName,
      builder: (context, state) {
        return DropdownButtonFormField(
          isDense: true,
          value: state.suffixName.value,
          decoration: InputDecoration(
            labelText: 'Suffix',
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
          onChanged: (value) => context.read<SignupBloc>().add(SuffixNameChanged(value!)),
          validator: (value) {
            return value == null
            ? 'Please select an option.'
            : null;
          },
          items: suffixStringList.map((item) {
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