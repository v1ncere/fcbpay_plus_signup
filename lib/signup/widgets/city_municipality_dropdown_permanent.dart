import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';

class CityMunicipalityDropdownPermanent extends StatelessWidget {
  const CityMunicipalityDropdownPermanent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.cityMunicipalityPermanentList != current.cityMunicipalityPermanentList
      || previous.cityMunicipalityPermanent != current.cityMunicipalityPermanent
      || previous.cityMunicipalityPermanentStatus != current.cityMunicipalityPermanentStatus,
      builder: (context, state) {
        if (state.cityMunicipalityPermanentStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.cityMunicipalityPermanentStatus.isFailure) {
          return Center(child: Text(state.message));
        }
        // default display
        return DropdownButtonFormField(
          value: state.cityMunicipalityPermanent.value,
          decoration: InputDecoration(
            labelText: 'City/Municipality',
            labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            errorText: state.cityMunicipalityPermanent.displayError?.text(),
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
          onChanged: (value) => context.read<SignupBloc>().add(CityMunicipalityPermanentChanged(value!)),
          items: state.cityMunicipalityPermanentList.map((e) {
            return DropdownMenuItem<String>(
              value: fixEncoding(e.name),
              child: Text(fixEncoding(e.name)),
              onTap: () { 
                context.read<SignupBloc>()
                ..add(PartialAddressPermanentRefreshed())
                ..add(BarangayPermanentFetched(e.code));
              }
            );
          }).toList()
        );
      }
    );
  }
}