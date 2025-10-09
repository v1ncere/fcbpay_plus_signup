part of 'search_address_cubit.dart';

sealed class SearchAddressState extends Equatable {
  const SearchAddressState();

  @override
  List<Object> get props => [];
}

final class SearchAddressInitial extends SearchAddressState {}

final class SearchAddressLoading extends SearchAddressState {}

final class SearchAddressLoaded extends SearchAddressState {
  const SearchAddressLoaded(this.suggestions);
  final List<PlaceSuggestion> suggestions;

  @override
  List<Object> get props => [suggestions];
}

final class SearchAddressError extends SearchAddressState {
  const SearchAddressError(this.message);
  final String message; 

  @override
  List<Object> get props => [message];
}
