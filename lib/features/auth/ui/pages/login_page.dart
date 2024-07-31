import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../core/di/injection_container.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailfocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordfocusNode = FocusNode();
  bool _passwordObscureText = true;

  bool _validateEmail() {
    final email = _emailController.text.trim();
    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            // AppLocalizations.of(context)!.invalidEmailErr,
            'Invalid email address. Please enter a valid email address.',
          ),
          hitTestBehavior: HitTestBehavior.deferToChild,
        ),
      );
      return false;
    }
    return true;
  }

  bool _validatePassword() {
    if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            // AppLocalizations.of(context)!.invalidPasswordErr,
            'Password cannot be empty. Please enter a valid password.',
          ),
          hitTestBehavior: HitTestBehavior.deferToChild,
        ),
      );
      return false;
    }
    return true;
  }

  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = sl<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      bloc: _loginCubit,
      listener: (_, state) {
        state.maybeWhen(
          success: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (_) => false,
            );
          },
          invalidCredentials: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  // AppLocalizations.of(context)!.invalidCredentialsErr,
                  'Invalid email or password. Please enter a valid email and password.',
                ),
                backgroundColor: Colors.red,
                hitTestBehavior: HitTestBehavior.deferToChild,
              ),
            );
          },
          error: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  // AppLocalizations.of(context)!.errorMsg,
                  'An error occurred. Please try again later.',
                ),
                backgroundColor: Colors.red,
                hitTestBehavior: HitTestBehavior.deferToChild,
              ),
            );
          },
          orElse: () {
            // do nothing
          },
        );
      },
      builder: (context, __) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // appBar: AppBar(
          //   title: Image.asset(
          //     'assets/images/app-logo.png',
          //     height: 0.05.sh,
          //   ),
          // ),
          body: LayoutBuilder(builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 64.h),
                          CustomTextField(
                            // hintText: AppLocalizations.of(context)!.emailHint,
                            hintText: 'Email',
                            controller: _emailController,
                            focusNode: _emailfocusNode,
                            prefixIcon: Icons.email_outlined,
                            onTap: () => setState(() {}),
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            // hintText:
                            //     AppLocalizations.of(context)!.passwordHint,
                            hintText: 'Password',
                            controller: _passwordController,
                            focusNode: _passwordfocusNode,
                            obscureText: _passwordObscureText,
                            onSuffixTap: () {
                              setState(() {
                                _passwordObscureText = !_passwordObscureText;
                              });
                            },
                            prefixIcon: Icons.lock_outline_rounded,
                            onTap: () => setState(() {}),
                          ),
                          // SizedBox(height: 8.h),
                          // Align(
                          //   alignment: Localizations.localeOf(context)
                          //               .languageCode ==
                          //           'en'
                          //       ? Alignment.centerRight
                          //       : Alignment.centerLeft,
                          //   child: TextButton(
                          //     onPressed: () {
                          //       Navigator.pushNamed(
                          //         context,
                          //         Routes.forgotPasswordPage,
                          //       );
                          //     },
                          //     child: Text(
                          //       AppLocalizations.of(context)!
                          //           .forgotPasswordLink,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 8.h),
                          ElevatedButton(
                            onPressed: () {
                              if (!_validateEmail()) return;
                              if (!_validatePassword()) return;

                              _loginCubit.login(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.r),
                              ),
                              minimumSize: const Size(double.maxFinite, 0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Text(
                                // AppLocalizations.of(context)!
                                //     .loginBtn
                                //     .toUpperCase(),
                                'Login',
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
