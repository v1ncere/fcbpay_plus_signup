import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';
import '../widgets/widgets.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Present Address',
          style: TextStyle(
            color: ColorString.jewel,
            fontWeight: FontWeight.w700,
            fontSize: 18
          )
        ),
        SizedBox(height: 5),
        BlocSelector<SignupBloc, SignupState, String>(
          selector: (state) => state.nationality.value ?? '',
          builder: (context, state) {
            if (state.isNotEmpty && state != 'Filipino') {
              return ForeignAddress();
            }
            return PhAddress();
          }
        )
      ]
    );
  }
}

class PhAddress extends StatelessWidget {
  const PhAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProvinceDropdown(),
        SizedBox(height: 10),
        CityMunicipalityDropdown(),
        SizedBox(height: 10),
        BarangayDropdown(),
        SizedBox(height: 10),
        ZipCodeTextfield(),
        SizedBox(height: 10),
        AddressChecker(),
        BlocSelector<SignupBloc, SignupState, bool>(
          selector: (state) => state.isSameAddress,
          builder: (context, isSameAddress) {
            if (isSameAddress) {
              return SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  'Permanent Address',
                  style: TextStyle(
                    color: ColorString.jewel,
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                  )
                ),
                SizedBox(height: 5),
                ProvinceDropdownPermanent(),
                SizedBox(height: 10),
                CityMunicipalityDropdownPermanent(),
                SizedBox(height: 10),
                BarangayDropdownPermanent(),
                SizedBox(height: 10),
                ZipCodeTextfieldPermanent(),
              ]
            );
          }
        )
      ]
    );
  }
}

class ForeignAddress extends StatelessWidget {
  const ForeignAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        ForeignAddressAutocomplete(),
        SizedBox(height: 10),
        AddressChecker(),
        BlocSelector<SignupBloc, SignupState, bool>(
          selector: (state) => state.isSameAddress,
          builder: (context, isSame) {
            if (isSame) {
              return SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Permanent Address',
                  style: TextStyle(
                    color: ColorString.jewel,
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                  )
                ),
                SizedBox(height: 5),
                ForeignAddressAutocompletePermanent(),
              ]
            );
          }
        )
      ]
    );
  }
}