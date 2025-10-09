import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cubit/search_address_cubit.dart';
import '../signup.dart';
import 'widgets.dart';

class ForeignAddressAutocomplete extends StatefulWidget {
  const ForeignAddressAutocomplete({super.key});
  
  @override
  State<ForeignAddressAutocomplete> createState() => ForeignAddressAutocompleteState();
}

class ForeignAddressAutocompleteState extends State<ForeignAddressAutocomplete> {
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TypeAheadField<PlaceSuggestion>(
          controller: addressController,
          builder: (context, controller, focusNode) {
            return CustomTextformfield(
              controller: controller,
              focusNode: focusNode,
              labelText: "Address",
              onChanged: (value) => context.read<SignupBloc>().add(ForeignAddressChanged(value)),
              suffixIcon: IconButton(
                icon: Icon(FontAwesomeIcons.x),
                color: ColorString.jewel,
                iconSize: 12,
                onPressed: () {
                  addressController.clear();
                  context.read<SignupBloc>().add(ForeignAddressCleared());
                }
              )
            );
          },
          debounceDuration: const Duration(milliseconds: 300),
          suggestionsCallback: (pattern) => context.read<SearchAddressCubit>().getSuggestions(pattern),
          onSelected: (suggestion) {
            addressController.text = suggestion.title;
            context.read<SignupBloc>().add(ForeignAddressChanged(suggestion.title));
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: const Icon(FontAwesomeIcons.locationDot),
              title: Text(suggestion.title)
            );
          },
          emptyBuilder: (context) => SizedBox.shrink(),
        );
      }
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}