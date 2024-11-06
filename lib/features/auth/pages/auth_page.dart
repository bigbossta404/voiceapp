import 'package:dicoding_voiceapp/core/app_color.dart';
import 'package:dicoding_voiceapp/features/auth/bloc/auth_bloc.dart';
import 'package:dicoding_voiceapp/features/auth/widgets/sso_button.dart';
import 'package:dicoding_voiceapp/helper/form_validator.dart';
import 'package:dicoding_voiceapp/helper/router_index.dart';
import 'package:dicoding_voiceapp/widget/custom_snackbar.dart';
import 'package:dicoding_voiceapp/widget/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool visibilityToggle = true;
  void visibilityPass() {
    setState(() {
      visibilityToggle = !visibilityToggle;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _emailController.text = 'aingmaung@mail.com';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.surfaceColor,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateLogin) {
              context.goNamed(RouterIndex.homePage);
            }
            if (state is AuthStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar(context, 'error', state.errorHandler ?? 'Error login'),
              );
            }
          },
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Login Account',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account? ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                              InkWell(
                                  onTap: () => context.pushNamed(RouterIndex.register),
                                  child: const Text('Create one',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.primaryColor))),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Form(
                                key: _loginFormKey,
                                child: Column(
                                  children: [
                                    CustomTextForm(
                                      controller: _emailController,
                                      hintText: 'Enter Email',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter an email';
                                        } else if (!value.isValidEmail) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                    CustomTextForm(
                                      controller: _passController,
                                      obscureText: true,
                                      hintText: 'Password',
                                      validator: (value) {
                                        if (value!.isEmpty || value.isValidEmail) {
                                          return 'Please enter a password';
                                        }
                                        return null;
                                      },
                                      visibilityTogle: visibilityToggle,
                                      visibilityPass: visibilityPass,
                                    )
                                  ],
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    // TODO
                                  },
                                  child: const Text('Recovery Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)))
                            ],
                          ),

                          // Button Login
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_loginFormKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(AuthEventLogin(_emailController.text, _passController.text));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      if (state is AuthStateLoading) {
                                        return const Text('Loading...',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textWhiteLightTheme));
                                      }
                                      return const Text('Login',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textWhiteLightTheme));
                                    },
                                  )),
                            ),
                          ),

                          // Devider
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColors.accent1,
                                    thickness: 0.5,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('or login with'),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.accent1,
                                    thickness: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // SSO Options
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SsoButton(svgAsset: 'assets/images/icons/google.svg'),
                              SsoButton(svgAsset: 'assets/images/icons/apple.svg', svgColor: AppColors.textBlackLightTheme),
                              SsoButton(svgAsset: 'assets/images/icons/facebook.svg', svgColor: Color.fromARGB(255, 27, 122, 199)),
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: const Text(
                          'By clicking login you agree to Voiceapp Term\'s of use and Privacy Policy',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textBlackLightTheme),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
