import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/search_address_cubit.dart';
import '../repository/repository.dart';
import '../signup.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF16794C))),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignupBloc()
            ..add(NationalityFetched())
            ..add(ProvinceFetched())
          ),
          BlocProvider(create: (context) => SearchAddressCubit(AWSLocationRepository()))
        ],
        child: SignupView()
      )
    );
  }
}