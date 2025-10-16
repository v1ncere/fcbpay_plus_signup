import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../signup.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState(
    birthdDateController: TextEditingController(),
    zipCodeController: TextEditingController(),
    zipCodePermanentController: TextEditingController(),
  )) {
    // textfield clear
    on<LastNameCleared>(_onLastNameCleared);
    on<FirstNameCleared>(_onFirstNameCleared);
    on<MiddleNameCleared>(_onMiddleNameCleared);
    on<BirthDateCleared>(_onBirthDateCleared);
    on<BirthAddressCleared>(_onBirthAddressCleared);
    on<ZipCodeCleared>(_onZipCodeCleared);
    on<ZipCodePermanentCleared>(_onZipCodePermanentCleared);
    on<ForeignAddressCleared>(_onForeignAddressCleared);
    on<ForeignPermanentAddressCleared>(_onForeignPermanentAddressCleared);
    on<PasswordCleared>(_onPasswordCleared);
    on<ConfirmedPasswordCleared>(_onConfirmedPasswordCleared);
    // full name
    on<LastNameChanged>(_onLastNameChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<MiddleNameChanged>(_onMiddleNameChanged);
    on<SuffixNameChanged>(_onSuffixNameChanged);
    on<GenderChanged>(_onGenderChanged);
    on<BirthDateChanged>(_onBirthDateChanged);
    on<NationalityChanged>(_onNationalityChanged);
    on<BirthAddressChanged>(_onBirthAddressChanged);
    // address
    on<ForeignAddressChanged>(_onForeignAddressChanged);
    on<ProvinceChanged>(_onProvinceChanged);
    on<CityMunicipalityChanged>(_onCityMunicipalityChanged);
    on<BarangayChanged>(_onBarangayChanged);
    on<ZipCodeChanged>(_onZipCodeChanged);
    //
    on<SameAddressChanged>(_onSameAddressChanged);
    //
    on<ForeignPermanentAddressChanged>(_onForeignPermanentAddressChanged);
    on<ProvincePermanentChanged>(_onProvincePermanentChanged);
    on<CityMunicipalityPermanentChanged>(_onCityMunicipalityPermanentChanged);
    on<BarangayPermanentChanged>(_onBarangayPermanentChanged);
    on<ZipCodePermanentChanged>(_onZipCodePermanentChanged);
    // fetch
    on<NationalityFetched>(_onNationalityFetched);
    on<ProvinceFetched>(_onProvinceFetched);
    on<CityMunicipalityFetched>(_onCityMunicipalityFetched);
    on<BarangayFetched>(_onBarangayFetched);
    on<ZipCodeFetched>(_onZipCodeFetched);
    on<AddressRefreshed>(_onAddressRefreshed);
    on<PartialAddressRefreshed>(_onPartialAddressRefreshed);

    on<CityMunicipalityPermanentFetched>(_onCityMunicipalityPermanentFetched);
    on<BarangayPermanentFetched>(_onBarangayPermanentFetched);
    on<ZipCodePermanentFetched>(_onZipCodePermanentFetched);
    on<AddressPermanentRefreshed>(_onAddressPermanentRefreshed);
    on<PartialAddressPermanentRefreshed>(_onPartialAddressPermanentRefreshed);
    // password
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<PasswordObscured>(_onPasswordObscured);
    on<ConfirmPasswordObscured>(_onConfirmPasswordObscured);
    on<HostResponseReceived>(_onHostResponseReceived);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  //* TEXTFIELD CLEAR */
  void _onLastNameCleared(LastNameCleared event, Emitter<SignupState> emit) {
    emit(state.copyWith(lastName: Name.pure()));
  }

  void _onFirstNameCleared(FirstNameCleared event, Emitter<SignupState> emit) {
    emit(state.copyWith(firstName: Name.pure()));
  }

  void _onMiddleNameCleared(MiddleNameCleared event, Emitter<SignupState> emit) {
    emit(state.copyWith(middleName: Name.pure()));
  }

  void _onBirthDateCleared(BirthDateCleared event, Emitter<SignupState> emit) {
    state.birthdDateController.clear();
  }

  void _onForeignAddressCleared(ForeignAddressCleared event, Emitter<SignupState> emit) {
    emit(state.copyWith(foreignPresentAddress: DropdownData.pure()));
  }

  void _onForeignPermanentAddressCleared(ForeignPermanentAddressCleared event, Emitter<SignupState> emit) {
    emit(state.copyWith(foreignPermanentAddress: DropdownData.pure()));
  }

  void _onBirthAddressCleared(BirthAddressCleared event, Emitter<SignupState> emit) {
    emit(state.copyWith(birthAddress: DropdownData.pure()));
  }
 
  void _onZipCodeCleared(ZipCodeCleared event, Emitter<SignupState> emit) {
    state.zipCodeController.clear();
    emit(state.copyWith(zipCode: Integer.pure()));
  }

  void _onZipCodePermanentCleared(ZipCodePermanentCleared event, Emitter<SignupState> emit) {
    state.zipCodePermanentController.clear();
    emit(state.copyWith(zipCodePermanent: Integer.pure()));
  }

  void _onPasswordCleared(PasswordCleared event, Emitter<SignupState> emit) {
    emit(state.copyWith(password: Password.pure()));
  }

  void _onConfirmedPasswordCleared(ConfirmedPasswordCleared event, Emitter<SignupState> emit) {
    emit(state.copyWith(confirmPassword: ConfirmedPassword.pure()));
  }

  //* FULL NAME **/
  void _onLastNameChanged(LastNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(lastName: Name.dirty(event.lastName)));
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(firstName: Name.dirty(event.firstName)));
  }

  void _onMiddleNameChanged(MiddleNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(middleName: Name.dirty(event.middleName)));  
  }

  void _onSuffixNameChanged(SuffixNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(suffixName: Name.dirty(event.suffixName)));
  }

  void _onGenderChanged(GenderChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(gender: DropdownData.dirty(event.gender)));
  }

  void _onNationalityChanged(NationalityChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(nationality: DropdownData.dirty(event.nationality)));
  }

  void _onBirthDateChanged(BirthDateChanged event, Emitter<SignupState> emit) {
    final dateString = DateFormat('dd/MM/yyyy').format(event.birthDate);
    emit(state.copyWith(birthdDateController: TextEditingController(text: dateString)));
  }

  void _onBirthAddressChanged(BirthAddressChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(birthAddress: DropdownData.dirty(event.address)));
  }

  //* ADDRESS **/
  void _onForeignAddressChanged(ForeignAddressChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(foreignPresentAddress: DropdownData.dirty(event.address)));
  }

  void _onForeignPermanentAddressChanged(ForeignPermanentAddressChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(foreignPermanentAddress: DropdownData.dirty(event.address)));
  }

  void _onProvinceChanged(ProvinceChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(province: DropdownData.dirty(event.province)));
  }

  void _onCityMunicipalityChanged(CityMunicipalityChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(cityMunicipality: DropdownData.dirty(event.cityMunicipality)));
  }

  void _onBarangayChanged(BarangayChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(barangay: DropdownData.dirty(event.barangay)));
  }

  void _onZipCodeChanged(ZipCodeChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(zipCode: Integer.dirty(event.zipCode)));
  }

  void _onSameAddressChanged(SameAddressChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(isSameAddress: event.isSameAddress));
  }

  void _onProvincePermanentChanged(ProvincePermanentChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(provincePermanent: DropdownData.dirty(event.province)));
  }

  void _onCityMunicipalityPermanentChanged(CityMunicipalityPermanentChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(cityMunicipalityPermanent: DropdownData.dirty(event.cityMunicipality)));
  }

  void _onBarangayPermanentChanged(BarangayPermanentChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(barangayPermanent: DropdownData.dirty(event.barangay)));
  }

  void _onZipCodePermanentChanged(ZipCodePermanentChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(zipCodePermanent: Integer.dirty(event.zipCode)));
  }

  //* PASSWORD **/
  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(confirmPassword: ConfirmedPassword.dirty(password: event.password, value: event.confirmPassword)));
  }

  void _onPasswordObscured(PasswordObscured event, Emitter<SignupState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordObscured(ConfirmPasswordObscured event, Emitter<SignupState> emit) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  //* FETCH **/
  Future<void> _onNationalityFetched(NationalityFetched event, Emitter<SignupState> emit) async {
    emit(state.copyWith(countryStatus: Status.loading));
    
    try {
      final url = Uri.https('e9ltva0fy5.execute-api.ap-southeast-2.amazonaws.com', '/default/flutterNationalityCorsEnable');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final countries = countryListFromJson(response.body);
        const priority = "Philippines";
        countries.sort((a, b) {
          if (a.name == priority) return -1;
          if (b.name == priority) return 1;
          return a.name.compareTo(b.name);
        });
        emit(state.copyWith(countryStatus: Status.success, countryList: countries));
      } else {
        emit(state.copyWith(countryStatus: Status.failure, message: response.body));
      }
    } catch (e) {
      emit(state.copyWith(countryStatus: Status.failure, message: e.toString()));
    }
  }

  Future<void> _onProvinceFetched(ProvinceFetched event, Emitter<SignupState> emit) async {
    emit(state.copyWith(provinceStatus: Status.loading));
    try {
      final url = Uri.https('psgc.gitlab.io', '/api/provinces.json');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> parsedData = json.decode(response.body);
        final provincies = parsedData.map((e) => Province.fromJson(e)).toList();
        provincies.sort((a, b) => a.name.compareTo(b.name));
        final noneProvince = Province('', 'N/A', '', '');
        emit(state.copyWith(provinceStatus: Status.success, provinceList: [noneProvince, ...provincies]));
      } else {
        emit(state.copyWith(provinceStatus: Status.failure, message: response.body));
      }
    } catch (_) {
      emit(state.copyWith(provinceStatus: Status.failure, message: 'Oops! Something went wrong.'));
    }
  }

  Future<void> _onCityMunicipalityFetched(CityMunicipalityFetched event, Emitter<SignupState> emit) async {
    emit(state.copyWith(cityMunicipalityStatus: Status.loading));
    
    try {
      if (event.provinceCode.isEmpty) {
        final url = Uri.https('psgc.gitlab.io', '/api/cities-municipalities.json');
        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final List<dynamic> parsed = json.decode(response.body);
          final municipalities = parsed.map((e) => CityMunicipality.fromJson(e)).toList();
          final newMunicipalities = municipalities.where((e) => e.provinceCode == false).toList()
          ..sort((a, b) => a.name.compareTo(b.name));
          emit(state.copyWith(cityMunicipalityStatus: Status.success, cityMunicipalityList: newMunicipalities));
        } else {
          emit(state.copyWith(cityMunicipalityStatus: Status.failure, message: response.body));
        }
      } else {
        final url = Uri.https('psgc.gitlab.io', '/api/provinces/${event.provinceCode}/cities-municipalities.json');
        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final List<dynamic> parsed = json.decode(response.body);
          final municipalities = parsed.map((e) => CityMunicipality.fromJson(e)).toList();
          municipalities.sort((a, b) => a.name.compareTo(b.name));
          emit(state.copyWith(cityMunicipalityStatus: Status.success, cityMunicipalityList: municipalities));
        } else {
          emit(state.copyWith(cityMunicipalityStatus: Status.failure, message: response.body));
        }
      }
    } catch (_) {
      emit(state.copyWith(cityMunicipalityStatus: Status.failure, message: 'Oops! Something went wrong.'));
    }
  }

  Future<void> _onBarangayFetched(BarangayFetched event, Emitter<SignupState> emit) async {
    emit(state.copyWith(barangayStatus: Status.loading));
    
    try {
      if (event.municipalityCode.isEmpty) return;
      final url = Uri.https('psgc.gitlab.io', '/api/cities-municipalities/${event.municipalityCode}/barangays.json');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final barangays = jsonResponse.map((e) => Barangay.fromJson(e)).toList();
        barangays.sort((a, b) => a.name.compareTo(b.name));
        emit(state.copyWith(barangayStatus: Status.success, barangayList: barangays));
      } else {
        emit(state.copyWith(barangayStatus: Status.failure, message: response.body));
      }
    } catch (_) {
      emit(state.copyWith(barangayStatus: Status.failure, message: 'Oops! Something went wrong.'));
    }
  }

  void _onZipCodeFetched(ZipCodeFetched event, Emitter<SignupState> emit) {
    emit(state.copyWith(zipCodeStatus: Status.success));
  }

  void _onAddressRefreshed(AddressRefreshed event, Emitter<SignupState> emit) {
    state.zipCodeController.clear();
    emit(state.copyWith(
      cityMunicipality: const DropdownData.pure(),
      cityMunicipalityList: const [],
      cityMunicipalityStatus: Status.initial,
      barangay: const DropdownData.pure(),
      barangayList: const [],
      barangayStatus: Status.initial,
      zipCode: Integer.pure(),
      zipCodeStatus: Status.initial,
    ));
  }

  void _onPartialAddressRefreshed(PartialAddressRefreshed event, Emitter<SignupState> emit) {
    state.zipCodeController.clear();
    emit(state.copyWith(
      barangay: const DropdownData.pure(),
      barangayList: const [],
      barangayStatus: Status.initial,
      zipCode: Integer.pure(),
      zipCodeStatus: Status.initial
    ));
  }

  Future<void> _onCityMunicipalityPermanentFetched(CityMunicipalityPermanentFetched event, Emitter<SignupState> emit) async {
    emit(state.copyWith(cityMunicipalityPermanentStatus: Status.loading));
    
    try {
      if (event.provinceCode.isEmpty) {
        final url = Uri.https('psgc.gitlab.io', '/api/cities-municipalities.json');
        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final List<dynamic> parsed = json.decode(response.body);
          final municipalities = parsed.map((e) => CityMunicipality.fromJson(e)).toList();
          final newMunicipalities = municipalities.where((e) => e.provinceCode == false).toList()
          ..sort((a, b) => a.name.compareTo(b.name));
          emit(state.copyWith(cityMunicipalityPermanentStatus: Status.success, cityMunicipalityPermanentList: newMunicipalities));
        } else {
          emit(state.copyWith(cityMunicipalityPermanentStatus: Status.failure, message: response.body));
        }
      } else {
        final url = Uri.https('psgc.gitlab.io', '/api/provinces/${event.provinceCode}/cities-municipalities.json');
        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final List<dynamic> parsed = json.decode(response.body);
          final municipalities = parsed.map((e) => CityMunicipality.fromJson(e)).toList();
          municipalities.sort((a, b) => a.name.compareTo(b.name));
          emit(state.copyWith(cityMunicipalityPermanentStatus: Status.success, cityMunicipalityPermanentList: municipalities));
        } else {
          emit(state.copyWith(cityMunicipalityPermanentStatus: Status.failure, message: response.body));
        }
      }
    } catch (_) {
      emit(state.copyWith(cityMunicipalityPermanentStatus: Status.failure, message: 'Oops! Something went wrong.'));
    }
  }

  Future<void> _onBarangayPermanentFetched(BarangayPermanentFetched event, Emitter<SignupState> emit) async {
    emit(state.copyWith(barangayPermanentStatus: Status.loading));
    
    try {
      if (event.municipalityCode.isEmpty) return;
      final url = Uri.https('psgc.gitlab.io', '/api/cities-municipalities/${event.municipalityCode}/barangays.json');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final barangays = jsonResponse.map((e) => Barangay.fromJson(e)).toList();
        barangays.sort((a, b) => a.name.compareTo(b.name));
        emit(state.copyWith(barangayPermanentStatus: Status.success, barangayPermanentList: barangays));
      } else {
        emit(state.copyWith(barangayPermanentStatus: Status.failure, message: response.body));
      }
    } catch (_) {
      emit(state.copyWith(barangayPermanentStatus: Status.failure, message: 'Oops! Something went wrong.'));
    }
  }

  void _onZipCodePermanentFetched(ZipCodePermanentFetched event, Emitter<SignupState> emit) {
    emit(state.copyWith(zipCodePermanentStatus: Status.success));
  }

  void _onAddressPermanentRefreshed(AddressPermanentRefreshed event, Emitter<SignupState> emit) {
    state.zipCodePermanentController.clear();
    emit(state.copyWith(
      cityMunicipalityPermanent: const DropdownData.pure(),
      cityMunicipalityPermanentList: const [],
      cityMunicipalityPermanentStatus: Status.initial,
      barangayPermanent: const DropdownData.pure(),
      barangayPermanentList: const [],
      barangayPermanentStatus: Status.initial,
      zipCodePermanent: Integer.pure(),
      zipCodePermanentStatus: Status.initial,
    ));
  }

  void _onPartialAddressPermanentRefreshed(PartialAddressPermanentRefreshed event, Emitter<SignupState> emit) {
    state.zipCodePermanentController.clear();
    emit(state.copyWith(
      barangayPermanent: const DropdownData.pure(),
      barangayPermanentList: const [],
      barangayPermanentStatus: Status.initial,
      zipCodePermanent: Integer.pure(),
      zipCodePermanentStatus: Status.initial
    ));
  }

  void _onHostResponseReceived(HostResponseReceived event, Emitter<SignupState> emit) {
    // Host responded (maybe success or error). Update state accordingly.
    final response = event.response;
    final isSuccess = response['success'] == true || response['status'] == 'ok';
    final message = event.response['message'] ?? 'No message';
    
    emit(state.copyWith(
      bridgeStatus: isSuccess 
      ? Status.success 
      : Status.failure,
      hostResponse: message
    ));
  }

  void _onSignupSubmitted(SignupSubmitted event, Emitter<SignupState> emit) {
    if (state.isNotValid) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
      emit(state.copyWith(status: Status.initial));
      return;
    }

    emit(state.copyWith(status: Status.loading));

    final payload = {
      'type': 'signup_request',
      'data': {
        'lastName': state.lastName.value,
        'firstName': state.firstName.value,
        'middleName': state.middleName.value,
        'suffixName': state.suffixName.value,
        'gender': state.gender.value,
        'nationality': state.nationality.value,
        'birthAddress': state.birthAddress.value,
        'province': state.province.value,
        'cityMunicipality': state.cityMunicipality.value,
        'barangay': state.barangay.value,
        'zipCode': state.zipCode.value,
        'provincePermanent': state.provincePermanent.value,
        'cityMunicipalityPermanent': state.cityMunicipalityPermanent.value,
        'barangayPermanent': state.barangayPermanent.value,
        'zipCodePermanent': state.zipCodePermanent.value,
        'foreignPresentAddress': state.foreignPresentAddress.value,
        'foreignPermanentAddress': state.foreignPermanentAddress.value,
        'password': state.password.value,
        'confirmPassword': state.confirmPassword.value, 
      } 
    };
    
    try {
      sendToHost(payload);
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
      emit(state.copyWith(status: Status.initial));
    }
    emit(state.copyWith(status: Status.initial));
  }

  @override
  Future<void> close() {
    state.birthdDateController.dispose();
    state.zipCodeController.dispose();
    state.zipCodePermanentController.dispose();
    return super.close();
  }
}
