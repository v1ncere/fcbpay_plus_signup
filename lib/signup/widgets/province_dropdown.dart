import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class ProvinceDropdown extends StatelessWidget {
  const ProvinceDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.provinceList != current.provinceList
      || previous.province != current.province
      || previous.provinceStatus != current.provinceStatus,
      builder: (context, state) {
        if (state.provinceStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.provinceStatus.isFailure) {
          return Center(
            child: TextButton(
              child: Text(
                TextString.pageError,
                textAlign: TextAlign.center,
              ),
              onPressed: () => context.read<SignupBloc>().add(ProvinceFetched()),
            )
          );
        }
        // default display
        return DropdownButtonFormField(
          value: state.province.value,
          hint: Text("Select Province"),
          decoration: InputDecoration(
            labelText: 'Province',
            labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            errorText: state.province.displayError?.text(),
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
          onChanged: (value) => context.read<SignupBloc>().add(ProvinceChanged(value!)),
          items: state.provinceList.map((e) {
            return DropdownMenuItem<String>(
              value: fixEncoding(e.name),
              child: Text(fixEncoding(e.name)),
              onTap: () {
                context.read<SignupBloc>()
                ..add(AddressRefreshed())
                ..add(CityMunicipalityFetched(e.code));
              }
            );
          }).toList()
        );
      }
    );
  }
}