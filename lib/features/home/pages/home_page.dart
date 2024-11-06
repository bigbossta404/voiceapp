// ignore_for_file: prefer_const_constructors
import 'package:dicoding_voiceapp/core/app_color.dart';
import 'package:dicoding_voiceapp/features/auth/bloc/auth_bloc.dart';
import 'package:dicoding_voiceapp/helper/router_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLogout) {
          context.goNamed(RouterIndex.auth);
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Menu and Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(45),
                      child: Image.asset(
                        'assets/images/icons/profile.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthEventLogout());
          },
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.logout_outlined,
            color: AppColors.textWhiteLightTheme,
          ),
        ),
      ),
    );
  }
}
