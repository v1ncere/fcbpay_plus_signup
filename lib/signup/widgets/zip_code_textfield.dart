import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import 'widgets.dart';

class ZipCodeTextfield extends StatelessWidget {
  const ZipCodeTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.zipCode != current.zipCode 
      || previous.zipCodeStatus != current.zipCodeStatus
      || previous.zipCodeController != current.zipCodeController,
      builder: (context, state) {
        if (state.zipCodeStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        // default display
        return CustomTextformfield(
          controller: state.zipCodeController,
          keyboardType: TextInputType.streetAddress,
          prefix: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            FontAwesomeIcons.addressBook,
            color: ColorString.eucalyptus,
            size: 18,
          )
        ),
          onChanged: (value) => context.read<SignupBloc>().add(ZipCodeChanged(value)),
          labelText: 'Zip Code',
          errorText: state.zipCode.displayError?.text(),
          suffixIcon: !state.zipCode.isPure
          ? IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              iconSize: 18,
              onPressed: () => context.read<SignupBloc>().add(ZipCodeCleared()),
            )
          : null,
        );
      }
    );
  }
}