import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class AddressChecker extends StatelessWidget {
  const AddressChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: state.isSameAddress,
              onChanged: (value) => context.read<SignupBloc>().add(SameAddressChanged(value ?? false))
            ),
            Text("Use present address as permanent address.")
          ]
        );
      }
    );
  }
}