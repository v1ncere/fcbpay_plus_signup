import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/repository.dart';
import '../signup.dart';

part 'search_address_state.dart';

class SearchAddressCubit extends Cubit<SearchAddressState> {
  SearchAddressCubit(this.awsLocationRepository) : super(SearchAddressInitial());

  final AWSLocationRepository awsLocationRepository;

  Future<List<PlaceSuggestion>> getSuggestions(String query) async {
    if (query.trim().isEmpty) return [];
    emit(SearchAddressLoading());

    try {
      final results = await awsLocationRepository.searchPlaces(query);
      emit(SearchAddressLoaded(results));
      return results;
    } catch (e) {
      emit(SearchAddressError(e.toString()));
      return [];
    }
  }
}
