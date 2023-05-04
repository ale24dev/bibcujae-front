import 'package:bibcujae/locator.dart';
import 'package:bibcujae/src/shared/repository/ApiResult.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../repositories/auth_repositories.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool _isSigned = false;

  bool get isSigned => _isSigned;

  void login(String username, String password) async {
    emit(AuthLoading());
    ApiResult apiResult =
        await serviceLocator<AuthRepository>().login(username, password);

    switch (apiResult.statusCode) {
      case 200:
        _isSigned = true;
        emit(AuthLoaded());
        break;

      default:
        emit(AuthError(apiResult: apiResult));
    }
  }

  void logout(BuildContext context) async {
    emit(AuthLoading());

    _isSigned = false;
    Future.delayed(Duration(seconds: 1)).then((value) {
      context.go("/");
      emit(AuthInitial());
    });
  }
}
