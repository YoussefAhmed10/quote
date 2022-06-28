part of 'random_qoute_cubit.dart';

abstract class RandomQouteStates extends Equatable {
  const RandomQouteStates();

  @override
  List<Object> get props => [];
}

class RandomQouteInitialState extends RandomQouteStates {}

class RandomQouteIsLoadingState extends RandomQouteStates {}

class RandomQouteSuccessState extends RandomQouteStates {
  final Qoute qoute;

  const RandomQouteSuccessState({required this.qoute});
  @override
  List<Object> get props => [qoute];
}

class RandomQouteErrorState extends RandomQouteStates {
  final String error;

  const RandomQouteErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
