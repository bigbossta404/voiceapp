// ignore_for_file: prefer_const_constructors
import 'package:dicoding_voiceapp/core/app_color.dart';
import 'package:dicoding_voiceapp/features/history/bloc/history_bloc.dart';
import 'package:dicoding_voiceapp/features/history/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/sidebar_menu.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _focusNode = FocusNode();
  final _searchController = TextEditingController();
  final HistoryBloc _historyBloc = HistoryBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List listLabel = ['All', 'Transcribed', 'In-Progress', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _historyBloc.add(LoadDataHistory());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Widget> chooseFilter(Bloc HistoryBloc) {
    List<Widget> btn = [];

    for (var i = 0; i < listLabel.length; i++) {
      btn.add(FilterButton(
        index: i,
        label: listLabel[i],
        historyBloc: HistoryBloc,
      ));
    }
    return btn;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: BlocProvider(
        create: (context) => _historyBloc,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: SideBarMenu(),
          body: SafeArea(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.surfaceColor,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: MediaQuery.viewPaddingOf(context).top),
              child: Column(
                children: [
                  // Menu and Profile
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.menu,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'History Record',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.5, color: AppColors.primaryColor), borderRadius: BorderRadius.circular(10)),
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
                  // Filtering
                  Column(
                    children: [
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
                      BlocBuilder<HistoryBloc, HistoryState>(
                        builder: (context, state) {
                          if (state is SelectedFilterState) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...listLabel.asMap().entries.map((item) {
                                  return InkWell(
                                    onTap: () {
                                      // Trigger the event to update the selected index
                                      context.read<HistoryBloc>().add(FilterBtnEvent(item.key));
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
                      ),
                    ],
                  ),
                  // Data history
                  SizedBox(
                    height: 20,
                  ),

                  BlocBuilder<HistoryBloc, HistoryState>(
                    builder: (context, state) {
                      if (state is LoadingGetData) {
                        return CircularProgressIndicator();
                      }
                      if (state is LoadDataState) {
                        return ListView.builder(
                          itemCount: state.data.length,
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: AppColors.accent1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // title dan action
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Play & title
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(color: AppColors.accent2, shape: BoxShape.circle),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.play_arrow,
                                                    size: 30,
                                                    color: AppColors.accent1,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              state.data[index].title,
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        // action menu
                                        Icon(Icons.more_vert_outlined)
                                      ],
                                    ),
                                    // Description note
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        state.data[index].description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            )),
          )),
        ),
      ),
    );
  }
}
