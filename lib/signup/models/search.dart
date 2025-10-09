import 'package:formz/formz.dart';

enum SearchValidationError { required, invalid }

class Search extends FormzInput<String, SearchValidationError> {
  const Search.pure() : super.pure('');
  const Search.dirty([super.value = '']) : super.dirty();
  
  @override
  SearchValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? SearchValidationError.required
      : null;
  }
}

extension SearchValidationErrorX on SearchValidationError {
  String text() {
    switch (this) {
      case SearchValidationError.required:
        return 'Please enter a search term.';
      case SearchValidationError.invalid:
        return 'Please enter a valid search term.';
    }
  }
}