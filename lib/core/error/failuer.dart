import 'package:equatable/equatable.dart';

abstract class Failuer extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailuer extends Failuer {}

class CachFailuer extends Failuer {}
