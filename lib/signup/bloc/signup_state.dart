part of 'signup_bloc.dart';

class SignupState extends Equatable with FormzMixin {
  // textfield controller
  final TextEditingController birthdDateController;
  final TextEditingController zipCodeController;
  final TextEditingController zipCodePermanentController;
  // fullname textfield
  final Name lastName;
  final Name firstName;
  final Name middleName;
  final Name suffixName;
  // other details dropdown
  final DropdownData gender;
  final DropdownData nationality;
  final DropdownData birthAddress;
  // address present dropdown
  final DropdownData province;
  final DropdownData cityMunicipality;
  final DropdownData barangay;
  final Integer zipCode;
  // address permanent dropdown
  final DropdownData provincePermanent;
  final DropdownData cityMunicipalityPermanent;
  final DropdownData barangayPermanent;
  final Integer zipCodePermanent;
  // foriegn address autocomplete
  final DropdownData foreignPresentAddress;
  final DropdownData foreignPermanentAddress;
  // nationality list
  final List<Country> countryList;
  // present address list
  final List<Province> provinceList;
  final List<CityMunicipality> cityMunicipalityList;
  final List<Barangay> barangayList;
  // checkbox
  final bool isSameAddress;
  // permanent address list
  final List<CityMunicipality> cityMunicipalityPermanentList;
  final List<Barangay> barangayPermanentList;
  // password textfield
  final Password password;
  final ConfirmedPassword confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  //
  final Map<String, dynamic>? hostResponse;
  // informational 
  final double progress;
  final String message;
  // statuses
  final Status birthAddressStatus;
  final Status countryStatus;
  final Status provinceStatus;
  final Status cityMunicipalityStatus;
  final Status barangayStatus;
  final Status zipCodeStatus;
  final Status cityMunicipalityPermanentStatus;
  final Status barangayPermanentStatus;
  final Status zipCodePermanentStatus;
  final Status bridgeStatus;
  final Status status;
  
  const SignupState({
    // textfield controller
    required this.birthdDateController,
    required this.zipCodeController,
    required this.zipCodePermanentController,
    // fullname textfields
    this.lastName = const Name.pure(),
    this.firstName = const Name.pure(),
    this.middleName = const Name.pure(),
    this.suffixName = const Name.dirty('N/A'),
    // other details textfields
    this.gender = const DropdownData.pure(),
    this.birthAddress = const DropdownData.pure(),
    this.nationality = const DropdownData.pure(),
    // address present dropdown
    this.province = const DropdownData.pure(),
    this.cityMunicipality = const DropdownData.pure(),
    this.barangay = const DropdownData.pure(),
    this.zipCode = const Integer.pure(),
    // checkbox
    this.isSameAddress = false,
    // address permanent dropdown
    this.provincePermanent = const DropdownData.pure(),
    this.cityMunicipalityPermanent = const DropdownData.pure(),
    this.barangayPermanent = const DropdownData.pure(),
    this.zipCodePermanent = const Integer.pure(),
    // foreign address
    this.foreignPresentAddress = const DropdownData.pure(),
    this.foreignPermanentAddress = const DropdownData.pure(),
    // lists
    this.countryList = const [],
    this.provinceList = const [],
    this.cityMunicipalityList = const [],
    this.barangayList = const [],
    this.cityMunicipalityPermanentList = const [],
    this.barangayPermanentList = const [],
    // password textfields
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    //
    this.hostResponse = const {},
    // informational
    this.progress = 0,
    this.message = "",
    // status
    this.birthAddressStatus = Status.initial,
    this.countryStatus = Status.initial,
    this.provinceStatus = Status.initial,
    this.cityMunicipalityStatus = Status.initial,
    this.barangayStatus = Status.initial,
    this.zipCodeStatus = Status.initial,
    this.cityMunicipalityPermanentStatus = Status.initial,
    this.barangayPermanentStatus = Status.initial,
    this.zipCodePermanentStatus = Status.initial,
    this.bridgeStatus = Status.initial,
    this.status = Status.initial,
  });

  @override
  List<FormzInput> get inputs => [
    lastName,
    firstName,
    middleName,
    suffixName,
    gender,
    nationality,
    birthAddress,
    if (nationality.value != 'Filipino') foreignPresentAddress,
    if (nationality.value != 'Filipino' && !isSameAddress) foreignPresentAddress,
    if (nationality.value == 'Filipino') province,
    if (nationality.value == 'Filipino') cityMunicipality,
    if (nationality.value == 'Filipino') barangay,
    if (nationality.value == 'Filipino') zipCode,
    if (nationality.value == 'Filipino' && !isSameAddress) provincePermanent,
    if (nationality.value == 'Filipino' && !isSameAddress) cityMunicipalityPermanent,
    if (nationality.value == 'Filipino' && !isSameAddress) barangayPermanent,
    if (nationality.value == 'Filipino' && !isSameAddress) zipCodePermanent,
    password,
    confirmPassword,
  ];

  SignupState copyWith({
    TextEditingController? birthdDateController,
    TextEditingController? zipCodeController,
    TextEditingController? zipCodePermanentController,
    Name? lastName,
    Name? firstName,
    Name? middleName,
    Name? suffixName,
    DropdownData? gender,
    DropdownData? nationality,
    DropdownData? birthAddress,
    DropdownData? province,
    DropdownData? cityMunicipality,
    DropdownData? barangay,
    Integer? zipCode,
    DropdownData? provincePermanent,
    DropdownData? cityMunicipalityPermanent,
    DropdownData? barangayPermanent,
    Integer? zipCodePermanent,
    DropdownData? foreignPresentAddress,
    DropdownData? foreignPermanentAddress,
    List<Country>? countryList,
    List<Province>? provinceList,
    List<CityMunicipality>? cityMunicipalityList,
    List<Barangay>? barangayList,
    bool? isSameAddress,
    List<CityMunicipality>? cityMunicipalityPermanentList,
    List<Barangay>? barangayPermanentList,
    Password? password,
    ConfirmedPassword? confirmPassword,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    Map<String, dynamic>? hostResponse,
    double? progress,
    String? message,
    Status? birthAddressStatus,
    Status? countryStatus,
    Status? provinceStatus,
    Status? cityMunicipalityStatus,
    Status? barangayStatus,
    Status? zipCodeStatus,
    Status? cityMunicipalityPermanentStatus,
    Status? barangayPermanentStatus,
    Status? zipCodePermanentStatus,
    Status? bridgeStatus,
    Status? status,
  }) {
    return SignupState(
      birthdDateController: birthdDateController ?? this.birthdDateController,
      zipCodeController: zipCodeController ?? this.zipCodeController,
      zipCodePermanentController: zipCodePermanentController ?? this.zipCodePermanentController,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      suffixName: suffixName ?? this.suffixName,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      birthAddress: birthAddress ?? this.birthAddress,
      province: province ?? this.province,
      cityMunicipality: cityMunicipality ?? this.cityMunicipality,
      barangay: barangay ?? this.barangay,
      zipCode: zipCode ?? this.zipCode,
      provincePermanent: provincePermanent ?? this.provincePermanent,
      cityMunicipalityPermanent: cityMunicipalityPermanent ?? this.cityMunicipalityPermanent,
      barangayPermanent: barangayPermanent ?? this.barangayPermanent,
      zipCodePermanent: zipCodePermanent ?? this.zipCodePermanent,
      foreignPresentAddress: foreignPresentAddress ?? this.foreignPresentAddress,
      foreignPermanentAddress: foreignPermanentAddress ?? this.foreignPermanentAddress,
      countryList: countryList ?? this.countryList,
      provinceList: provinceList ?? this.provinceList,
      cityMunicipalityList: cityMunicipalityList ?? this.cityMunicipalityList,
      barangayList: barangayList ?? this.barangayList,
      isSameAddress: isSameAddress ?? this.isSameAddress,
      cityMunicipalityPermanentList: cityMunicipalityPermanentList ?? this.cityMunicipalityPermanentList,
      barangayPermanentList: barangayPermanentList ?? this.barangayPermanentList,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      hostResponse: hostResponse ?? this.hostResponse,
      progress: progress ?? this.progress,
      message: message ?? this.message,
      birthAddressStatus: birthAddressStatus ?? this.birthAddressStatus,
      countryStatus: countryStatus ?? this.countryStatus,
      provinceStatus: provinceStatus ?? this.provinceStatus,
      cityMunicipalityStatus: cityMunicipalityStatus ?? this.cityMunicipalityStatus,
      barangayStatus: barangayStatus ?? this.barangayStatus,
      zipCodeStatus: zipCodeStatus ?? this.zipCodeStatus,
      cityMunicipalityPermanentStatus: cityMunicipalityPermanentStatus ?? this.cityMunicipalityPermanentStatus,
      barangayPermanentStatus: barangayPermanentStatus ?? this.barangayPermanentStatus,
      zipCodePermanentStatus: zipCodePermanentStatus ?? this.zipCodePermanentStatus,
      bridgeStatus: bridgeStatus ?? this.bridgeStatus,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      birthdDateController,
      zipCodeController,
      zipCodePermanentController,
      lastName,
      firstName,
      middleName,
      suffixName,
      gender,
      nationality,
      birthAddress,
      province,
      cityMunicipality,
      barangay,
      zipCode,
      provincePermanent,
      cityMunicipalityPermanent,
      barangayPermanent,
      zipCodePermanent,
      foreignPresentAddress,
      foreignPermanentAddress,
      countryList,
      provinceList,
      cityMunicipalityList,
      barangayList,
      isSameAddress,
      cityMunicipalityPermanentList,
      barangayPermanentList,
      password,
      confirmPassword,
      obscurePassword,
      obscureConfirmPassword,
      hostResponse,
      progress,
      message,
      birthAddressStatus,
      countryStatus,
      provinceStatus,
      cityMunicipalityStatus,
      barangayStatus,
      zipCodeStatus,
      cityMunicipalityPermanentStatus,
      barangayPermanentStatus,
      zipCodePermanentStatus,
      bridgeStatus,
      status,
    ];
  }
}
