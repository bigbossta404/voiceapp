import 'package:dicoding_voiceapp/core/app_color.dart';
import 'package:dicoding_voiceapp/features/auth/presentation/widgets/sso_button.dart';
import 'package:dicoding_voiceapp/helper/form_validator.dart';
import 'package:dicoding_voiceapp/widget/custom_textform.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _loginFormKey = GlobalKey<FormState>();
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account? ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                        Text('Create one', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.primaryColor)),
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
                                hintText: 'Username / Email',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  } else if (!value.isValidEmail) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  // TODO
                                },
                              ),
                              CustomTextForm(
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
                                onSaved: (value) {
                                  // TODO
                                },
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
                              // TODO
                              if (_loginFormKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text('Login',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textWhiteLightTheme))),
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
                const Text(
                  'By clicking login you agree to Voiceapp Term\'s of use and Privacy Policy',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textBlackLightTheme),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
