import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import 'widgets.dart';

class ZipCodeTextfieldPermanent extends StatelessWidget {
  const ZipCodeTextfieldPermanent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.zipCodePermanent != current.zipCodePermanent 
      || previous.zipCodePermanentStatus != current.zipCodePermanentStatus
      || previous.zipCodePermanentController != current.zipCodePermanentController,
      builder: (context, state) {
        if (state.zipCodePermanentStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        // default display
        return CustomTextformfield(
          controller: state.zipCodePermanentController,
          keyboardType: TextInputType.streetAddress,
          prefix: Padding(
          padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              FontAwesomeIcons.addressBook,
              color: ColorString.eucalyptus,
              size: 18,
            )
          ),
          onChanged: (value) => context.read<SignupBloc>().add(ZipCodePermanentChanged(value)),
          labelText: 'Zip Code',
          errorText: state.zipCodePermanent.displayError?.text(),
          suffixIcon: !state.zipCodePermanent.isPure
          ? IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              iconSize: 18,
              onPressed: () => context.read<SignupBloc>().add(ZipCodePermanentCleared()),
            )
          : null,
        );
      }
    );
  }
}