import 'package:bibcujae/src/features/auth/cubit/auth_cubit.dart';
import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../resources/assets.dart';
import '../../../../resources/general_styles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;

  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GStyles.colorCrema,
        body: Row(
          children: [
            SizedBox(
                width: 50.w,
                child: Image.asset(AppAsset.imageLogin, fit: BoxFit.cover)),
            SizedBox(
              width: 50.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Image.asset(AppAsset.cujaeLogo, height: 26.h)),
                    //Center(child: Image.asset(AppAsset.logo, height: 26.h)),
                    SizedBox(height: 10.sp),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Libroteca",
                          style: context.textTheme.bodyText1
                              ?.copyWith(fontSize: 13.sp)),
                    ),
                    Divider(color: Colors.grey[300]),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Sistema Integrado de Gestión Bibliotecaria",
                          style: context.textTheme.bodyText1
                              ?.copyWith(fontSize: 11.sp)),
                    ),
                    Text("Usuario",
                        style: context.textTheme.bodyText1
                            ?.copyWith(fontSize: 11.sp)),
                    SizedBox(height: 4.sp),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.sp)),
                      child: TextField(
                        style: context.textTheme.bodyText1,
                        controller: usernameController,
                        decoration: InputDecoration(
                            hintText: "Nombre de usuario",
                            hintStyle: context.textTheme.bodyText1
                                ?.copyWith(color: Colors.black87),
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.black),
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    Text("Contraseña",
                        style: context.textTheme.bodyText1
                            ?.copyWith(fontSize: 11.sp)),
                    SizedBox(height: 4.sp),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.sp)),
                      child: TextField(
                        style: context.textTheme.bodyText1,
                        obscureText: !passwordVisible,
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "Contraseña",
                            hintStyle: context.textTheme.bodyText1
                                ?.copyWith(color: Colors.black87),
                            prefixIcon:
                                const Icon(Icons.password, color: Colors.black),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.remove_red_eye,
                                    color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                }),
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case AuthLoading:
                            return Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.sp),
                                        child: const CircularProgressIndicator
                                                .adaptive(
                                            backgroundColor: Colors.white),
                                      )),
                                ),
                              ],
                            );

                          case AuthInitial:
                            return Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        context.read<AuthCubit>().login(
                                            usernameController.text,
                                            passwordController.text);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.sp),
                                        child: Text("Iniciar sesión",
                                            style: context.textTheme.bodyText1
                                                ?.copyWith(
                                                    color: Colors.white)),
                                      )),
                                ),
                              ],
                            );
                          case AuthLoaded:
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.go("/home");
                            });

                            return Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.sp),
                                        child: const CircularProgressIndicator
                                                .adaptive(
                                            backgroundColor: Colors.white),
                                      )),
                                ),
                              ],
                            );
                          case AuthError:
                            return Column(
                              children: [
                                Text(
                                  (state as AuthError)
                                      .apiResult
                                      .responseObject
                                      .toString(),
                                  style: context.textTheme.bodyText1
                                      ?.copyWith(color: GStyles.colorFail),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            context.read<AuthCubit>().login(
                                                usernameController.text,
                                                passwordController.text);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.sp),
                                            child: Text("Iniciar sesión",
                                                style: context
                                                    .textTheme.bodyText1
                                                    ?.copyWith(
                                                        color: Colors.white)),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          default:
                            return Text("Error inesperado",
                                style: context.textTheme.bodyText1);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
