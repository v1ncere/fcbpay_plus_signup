import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class BarangayDropdownPermanent extends StatelessWidget {
  const BarangayDropdownPermanent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.barangayPermanentList != current.barangayPermanentList
      || previous.barangayPermanent != current.barangayPermanent
      || previous.barangayPermanentStatus != current.barangayPermanentStatus,
      builder: (context, state) {
        if (state.barangayPermanentStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.barangayPermanentStatus.isFailure) {
          return Center(
            child: Text(state.message)
          );
        }
        // default display
        return DropdownButtonFormField(
          value: state.barangayPermanent.value,
          decoration: InputDecoration(
            labelText: 'Barangay',
            labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            errorText: state.barangayPermanent.displayError?.text(),
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
          onChanged: (value) => context.read<SignupBloc>().add(BarangayPermanentChanged(value!)),
          items: state.barangayPermanentList.map((e) {
            return DropdownMenuItem<String> (
              value: fixEncoding(e.name),
              child: Text(fixEncoding(e.name)),
              onTap: () => context.read<SignupBloc>().add(ZipCodePermanentFetched()),
            );
          }).toList()
        );
      }
    );
  }
}