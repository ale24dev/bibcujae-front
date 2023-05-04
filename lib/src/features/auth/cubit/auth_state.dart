part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {}

class AuthError extends AuthState {
  final ApiResult apiResult;

  const AuthError({required this.apiResult});
}
