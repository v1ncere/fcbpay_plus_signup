import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widgets/widgets.dart';

class FullNameView extends StatelessWidget {
  const FullNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name',
          style: TextStyle(
            color: ColorString.jewel,
            fontWeight: FontWeight.w700,
            fontSize: 18
          )
        ),
        SizedBox(height: 10),
        LastNameTextfield(),
        SizedBox(height: 10),
        FirstNameTextfield(),
        SizedBox(height: 10),
        MiddleNameTextfield(),
        SizedBox(height: 10),
        SuffixDropdown(),
        SizedBox(height: 20),
        BirthdateTextfield(),
        SizedBox(height: 10),
        GenderDropdown(),
        SizedBox(height: 10),
        NationalityDropdown(),
        SizedBox(height: 10),
        BirthAddress(),
      ]
    );
  }
}