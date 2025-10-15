import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signup.dart';
import '../widgets/widgets.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});
  
  @override
  State<SignupView> createState() => SignupViewState();
}

class SignupViewState extends State<SignupView> {

  @override
  void initState() {
    super.initState();
    
    registerHostListener((payload) {
      context.read<SignupBloc>().add(HostResponseReceived(payload));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            _showSuccessSnackbar(context, state.message);
          }
          if (state.status.isFailure) {
            _showFailureSnackbar(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              FullNameView(),
              SizedBox(height: 15),
              AddressView(),
              SizedBox(height: 15),
              PasswordView(),
              SizedBox(height: 30),
              BottomButton(),
            ]
          )
        )
      )
    );
  }

    // show success dialog 
  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.solidCircleCheck,
      backgroundColor: ColorString.eucalyptus,
      foregroundColor: ColorString.white
    ));
  }

  // show failure snackbar
  void _showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.triangleExclamation,
      backgroundColor: ColorString.guardsmanRed,
      foregroundColor: ColorString.white
    ));
  }
}