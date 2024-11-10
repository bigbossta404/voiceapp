// ignore_for_file: prefer_const_constructors
import 'package:dicoding_voiceapp/core/app_color.dart';
import 'package:dicoding_voiceapp/features/auth/bloc/auth_bloc.dart';
import 'package:dicoding_voiceapp/features/home/bloc/home_bloc.dart';
import 'package:dicoding_voiceapp/features/home/widgets/filter_button.dart';
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
  final _focusNode = FocusNode();
  final _searchController = TextEditingController();
  List listLabel = ['All', 'Transcribed', 'In-Progress', 'Cancelled'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  List<Widget> chooseFilter(Bloc HomeBloc) {
    List<Widget> btn = [];

    for (var i = 0; i < listLabel.length; i++) {
      btn.add(FilterButton(
        index: i,
        label: listLabel[i],
        homeBloc: HomeBloc,
      ));
    }
    return btn;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLogout) {
          context.goNamed(RouterIndex.auth);
        }
      },
      child: GestureDetector(
        onTap: () => _focusNode.unfocus(),
        child: BlocProvider(
          create: (context) => HomeBloc(),
          child: Scaffold(
            body: SafeArea(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.surfaceColor,
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Menu and Profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.menu,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                            width: 50.0,
                            height: 50.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 15,
                                  color: Color.fromARGB(78, 173, 173, 173),
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/icons/profile.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Image.asset('assets/images/user-default.png', fit: BoxFit.cover);
                              },
                            ))
                      ],
                    ),
                    // Filtering
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recordings',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.5, color: AppColors.primaryColor), borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.voice_chat,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '0',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: TextField(
                            controller: _searchController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.errorColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.errorColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: AppColors.accent3,
                              filled: true,
                              hintText: 'Search recordings',
                              border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                              hintStyle: const TextStyle(fontSize: 14),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is SelectedFilterState) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ...listLabel.asMap().entries.map((item) {
                                    return InkWell(
                                      onTap: () {
                                        // Trigger the event to update the selected index
                                        context.read<HomeBloc>().add(FilterBtnEvent(item.key));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: state.index == item.key ? AppColors.primaryColor : null,
                                          border: Border.all(
                                            width: 0.5,
                                            color: AppColors.primaryColor,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              // Display the selected index
                                              listLabel[item.key],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: state.index == item.key ? AppColors.textWhiteLightTheme : AppColors.textBlackLightTheme,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                ],
                              );
                            } else {
                              return Container(); // Default case if no state is available
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              )),
            )),
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
        ),
      ),
    );
  }
}
