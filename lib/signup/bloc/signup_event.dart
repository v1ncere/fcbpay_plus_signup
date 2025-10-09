part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

//* TEXTFIELD CLEAR **/
final class LastNameCleared extends SignupEvent {}

final class FirstNameCleared extends SignupEvent {}

final class MiddleNameCleared extends SignupEvent {}

final class BirthDateCleared extends SignupEvent {}

final class BirthAddressCleared extends SignupEvent {}

final class ForeignAddressCleared extends SignupEvent {}

final class ForeignPermanentAddressCleared extends SignupEvent {}

final class ZipCodeCleared extends SignupEvent {}

final class ZipCodePermanentCleared extends SignupEvent {}

final class PasswordCleared extends SignupEvent {}

final class ConfirmedPasswordCleared extends SignupEvent {}

//* FULL NAME **/
final class LastNameChanged extends SignupEvent {
  const LastNameChanged(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class FirstNameChanged extends SignupEvent {
  const FirstNameChanged(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class MiddleNameChanged extends SignupEvent {
  const MiddleNameChanged(this.middleName);
  final String middleName;

  @override
  List<Object> get props => [middleName];
}

final class SuffixNameChanged extends SignupEvent {
  const SuffixNameChanged(this.suffixName);
  final String suffixName;

  @override
  List<Object> get props => [suffixName];
}

final class GenderChanged extends SignupEvent {
  const GenderChanged(this.gender);
  final String gender;

  @override
  List<Object> get props => [gender];
}

final class NationalityChanged extends SignupEvent {
  const NationalityChanged(this.nationality);
  final String nationality;

  @override
  List<Object> get props => [nationality];
}

final class BirthDateChanged extends SignupEvent {
  const BirthDateChanged(this.birthDate);
  final DateTime birthDate;

  @override
  List<Object> get props => [birthDate];
}

final class BirthAddressChanged extends SignupEvent {
  const BirthAddressChanged(this.address);
  final String address;

  @override
  List<Object> get props => [address];
}

//* ADDRESS **/
final class ForeignAddressChanged extends SignupEvent {
  const ForeignAddressChanged(this.address);
  final String address;

  @override
  List<Object> get props => [address];
}

final class ForeignPermanentAddressChanged extends SignupEvent {
  const ForeignPermanentAddressChanged(this.address);
  final String address;

  @override
  List<Object> get props => [address];
}

final class ProvinceChanged extends SignupEvent {
  const ProvinceChanged(this.province);
  final String province;

  @override
  List<Object> get props => [province];
}

final class CityMunicipalityChanged extends SignupEvent {
  const CityMunicipalityChanged(this.cityMunicipality);
  final String cityMunicipality;

  @override
  List<Object> get props => [cityMunicipality];
}

final class BarangayChanged extends SignupEvent {
  const BarangayChanged(this.barangay);
  final String barangay;

  @override
  List<Object> get props => [barangay];
}

final  class ZipCodeChanged extends SignupEvent {
  const ZipCodeChanged(this.zipCode);
  final String zipCode;

  @override
  List<Object> get props => [zipCode];
}

final class SameAddressChanged extends SignupEvent {
  const SameAddressChanged(this.isSameAddress);
  final bool isSameAddress;

  @override
  List<Object> get props => [isSameAddress];
}

final class ProvincePermanentChanged extends SignupEvent {
  const ProvincePermanentChanged(this.province);
  final String province;

  @override
  List<Object> get props => [province];
}

final class CityMunicipalityPermanentChanged extends SignupEvent {
  const CityMunicipalityPermanentChanged(this.cityMunicipality);
  final String cityMunicipality;

  @override
  List<Object> get props => [cityMunicipality];
}

final class BarangayPermanentChanged extends SignupEvent {
  const BarangayPermanentChanged(this.barangay);
  final String barangay;

  @override
  List<Object> get props => [barangay];
}

final  class ZipCodePermanentChanged extends SignupEvent {
  const ZipCodePermanentChanged(this.zipCode);
  final String zipCode;

  @override
  List<Object> get props => [zipCode];
}

//* FETCH **/
final class NationalityFetched extends SignupEvent {}

final class ProvinceFetched extends SignupEvent {}

final class CityMunicipalityFetched extends SignupEvent {
  const CityMunicipalityFetched(this.provinceCode);
  final String provinceCode;

  @override
  List<Object> get props => [provinceCode];
}

final class BarangayFetched extends SignupEvent {
  const BarangayFetched(this.municipalityCode);
  final String municipalityCode;

  @override
  List<Object> get props => [municipalityCode];
}

final class ZipCodeFetched extends SignupEvent {}

final class AddressRefreshed extends SignupEvent {}

final class PartialAddressRefreshed extends SignupEvent {}

final class CityMunicipalityPermanentFetched extends SignupEvent {
  const CityMunicipalityPermanentFetched(this.provinceCode);
  final String provinceCode;

  @override
  List<Object> get props => [provinceCode];
}

final class BarangayPermanentFetched extends SignupEvent {
  const BarangayPermanentFetched(this.municipalityCode);
  final String municipalityCode;

  @override
  List<Object> get props => [municipalityCode];
}

final class ZipCodePermanentFetched extends SignupEvent {}

final class AddressPermanentRefreshed extends SignupEvent {}

final class PartialAddressPermanentRefreshed extends SignupEvent {}

//* PASSWORD **/
final class PasswordChanged extends SignupEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class ConfirmPasswordChanged extends SignupEvent {
  const ConfirmPasswordChanged({required this.confirmPassword, required this.password});
  final String confirmPassword;
  final String password;

  @override
  List<Object> get props => [confirmPassword, password];
}

final class PasswordObscured extends SignupEvent {}

final class ConfirmPasswordObscured extends SignupEvent {}

final class SignupSubmitted extends SignupEvent {}

final class HostResponseReceived extends SignupEvent {
  final Map<String, dynamic> response;
  const HostResponseReceived(this.response);

  @override
  List<Object> get props => [response];
}