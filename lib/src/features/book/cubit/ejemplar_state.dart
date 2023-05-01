part of 'ejemplar_cubit.dart';

abstract class EjemplarState extends Equatable {
  const EjemplarState();

  @override
  List<Object> get props => [];
}

class EjemplarInitial extends EjemplarState {}

class EjemplarLoading extends EjemplarState {}

class EjemplarEmpty extends EjemplarState {}

class EjemplarCreated extends EjemplarState {
  final ApiResult apiResult;

  const EjemplarCreated({required this.apiResult});
}

class EjemplarLoaded extends EjemplarState {
  final ApiResult apiResult;

  const EjemplarLoaded({required this.apiResult});
}

class EjemplarUpdated extends EjemplarState {}

class EjemplarDeleted extends EjemplarState {}

class EjemplarError extends EjemplarState {
  final ApiResult apiResult;

  const EjemplarError({required this.apiResult});
}
