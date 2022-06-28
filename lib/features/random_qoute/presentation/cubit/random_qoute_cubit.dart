import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qoutes/core/error/failuer.dart';
import 'package:qoutes/core/usecases/usecase.dart';
import 'package:qoutes/core/utils/app_string.dart';
import 'package:qoutes/features/random_qoute/domain/entities/qoute.dart';
import 'package:qoutes/features/random_qoute/domain/usecases/get_random_qoute.dart';

part 'random_qoute_state.dart';

class RandomQouteCubit extends Cubit<RandomQouteStates> {
  RandomQouteCubit({required this.getRandomQouteUseCase})
      : super(RandomQouteInitialState());

  static RandomQouteCubit get(context) => BlocProvider.of(context);

  final GetRandomQoute getRandomQouteUseCase;

  Future<void> getRandomQoute() async {
    emit(RandomQouteIsLoadingState());
    Either<Failuer, Qoute> response =
        await getRandomQouteUseCase.call(NoParmes());

    return emit(
      response.fold(
        (failuer) => RandomQouteErrorState(error: mapFailuerMsg(failuer)),
        (qoute) => RandomQouteSuccessState(qoute: qoute),
      ),
    );
  }

  String mapFailuerMsg(Failuer failuer) {
    switch (failuer.runtimeType) {
      case ServerFailuer:
        return AppString.serverFailure;
      case CachFailuer:
        return AppString.cacheFailuer;

      default:
        return AppString.unxcepectedFailuer;
    }
  }
}
