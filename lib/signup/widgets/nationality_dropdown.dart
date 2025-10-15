import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class NationalityDropdown extends StatelessWidget {
  const NationalityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.nationality != current.nationality
      || previous.countryList != current.countryList
      || previous.countryStatus != current.countryStatus,
      builder: (context, state) {
        if (state.countryStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.countryStatus.isSuccess) {
          return DropdownButtonFormField(
            value: state.nationality.value,
            isExpanded: true,
            hint: Text("Select Nationality"),
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Nationality',
              labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
              errorText: state.nationality.displayError?.text(),
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
            onChanged: (value) => context.read<SignupBloc>().add(NationalityChanged(value!)),
            items: state.countryList.map((e) {
              return DropdownMenuItem<String>(
                value: fixEncoding(e.demonym!),
                child: Text(fixEncoding(e.demonym!)),
              );
            }).toList()
          );
        }
        if (state.countryStatus.isFailure) {
          return Center(
            child: TextButton(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
              ),
              onPressed: () => context.read<SignupBloc>().add(NationalityFetched()),
            )
          );
        }
        // default display
        return const SizedBox.shrink();
      }
    );
  }
}