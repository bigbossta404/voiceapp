import 'package:dicoding_voiceapp/features/auth/bloc/auth_bloc.dart';
import 'package:dicoding_voiceapp/features/home/pages/home_page.dart';
import 'package:dicoding_voiceapp/helper/form_validator.dart';
import 'package:dicoding_voiceapp/helper/router_index.dart';
import 'package:dicoding_voiceapp/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_color.dart';
import '../../../widget/custom_textform.dart';
import '../widgets/sso_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _regisFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _repassController = TextEditingController();

  bool visibilityToggle = true;
  void visibilityPass() {
    setState(() {
      visibilityToggle = !visibilityToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.surfaceColor,
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {},
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
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
                            'Create Account',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account? ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                              InkWell(
                                  onTap: () {
                                    context.goNamed(RouterIndex.auth);
                                  },
                                  child: const Text('Login',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.primaryColor))),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 10),
                            child: Form(
                                key: _regisFormKey,
                                child: Column(
                                  children: [
                                    CustomTextForm(
                                      controller: _emailController,
                                      hintText: 'Username / Email',
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
                                      controller: _repassController,
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
                                    ),
                                    CustomTextForm(
                                      controller: _passController,
                                      obscureText: true,
                                      hintText: 'Re-Enter Password',
                                      validator: (value) {
                                        if (value!.isEmpty || value.isValidEmail) {
                                          return 'Please enter a password';
                                        }
                                        if (value != _passController.text) {
                                          return 'Password do not match';
                                        }
                                        return null;
                                      },
                                      visibilityTogle: visibilityToggle,
                                      visibilityPass: visibilityPass,
                                    )
                                  ],
                                )),
                          ),

                          // Button Create
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_regisFormKey.currentState!.validate()) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthEventCreate(_emailController.text, _passController.text, _repassController.text));
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
                                        return const CircularProgressIndicator(
                                          color: AppColors.surfaceColor,
                                        );
                                      }
                                      return const Text('Create',
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
                                  child: Text('or create with'),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: const Text(
                          'By clicking Create account you agree to Voiceapp Term\'s of use and Privacy Policy',
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
