import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class BarangayDropdown extends StatelessWidget {
  const BarangayDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.barangayList != current.barangayList
      || previous.barangay != current.barangay
      || previous.barangayStatus != current.barangayStatus,
      builder: (context, state) {
        if (state.barangayStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.barangayStatus.isFailure) {
          return Center(
            child: Text(state.message)
          );
        }
        // default display
        return DropdownButtonFormField(
          value: state.barangay.value,
          decoration: InputDecoration(
            labelText: 'Barangay',
            labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            errorText: state.barangay.displayError?.text(),
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
          onChanged: (value) => context.read<SignupBloc>().add(BarangayChanged(value!)),
          items: state.barangayList.map((e) {
            return DropdownMenuItem<String> (
              value: fixEncoding(e.name),
              child: Text(fixEncoding(e.name)),
              onTap: () => context.read<SignupBloc>().add(ZipCodeFetched()),
            );
          }).toList()
        );
      }
    );
  }
}