// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management/screens/tasks_page/new_task_page.dart';
import 'package:task_management/screens/tasks_page/tasks_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    super.key,
  });

  static const String routeName = 'my-page';
  static const String route = '/my-page';

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex;
  double _scaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showNewTaskBottomSheet(BuildContext context) async {
    setState(() {
      _scaleFactor = 0.9; // Shrink the background slightly
    });

    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.grey.withAlpha(125),
        builder: (context) => NewTaskPage());

    setState(() {
      _scaleFactor = 1.0; // Restore background after closing sheet
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedScale(
        duration: Duration(milliseconds: 300),
        scale: _scaleFactor,
        child: SafeArea(
          child: AnimatedContainer(
            decoration: _scaleFactor < 1
                ? BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    border: Border.all(
                      color: Colors.black.withAlpha(50),
                    ),
                  )
                : null,
            duration: Duration(milliseconds: 300),
            child: Stack(
              children: [
                Positioned(
                  right: 25,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () {
                      _showNewTaskBottomSheet(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        color: Colors.indigoAccent,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    // if (_currentIndex == 0)
                    //   AnimatedContainer(
                    //     duration: Duration(milliseconds: 500),
                    //     child: Padding(
                    //       padding: EdgeInsets.all(8.0),
                    //       child: Text('Tasks'),
                    //     ),
                    //   ),
                    // if (_currentIndex == 1)
                    //   AnimatedContainer(
                    //     duration: Duration(milliseconds: 500),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: CustomExpansionTile(
                    //         expandedChildren: [
                    //           SizedBox(height: 8),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             spacing: 8.0,
                    //             children: [
                    //               Icon(
                    //                 Icons.disabled_by_default_outlined,
                    //                 size: 35,
                    //               ),
                    //               Icon(
                    //                 Icons.disabled_by_default_outlined,
                    //                 size: 35,
                    //               ),
                    //               Icon(
                    //                 Icons.disabled_by_default_outlined,
                    //                 size: 35,
                    //               ),
                    //               Icon(
                    //                 Icons.disabled_by_default_outlined,
                    //                 size: 35,
                    //               ),
                    //               Icon(
                    //                 Icons.disabled_by_default_outlined,
                    //                 size: 35,
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Icon(
                    //               Icons.safety_check,
                    //               size: 35,
                    //             ),
                    //             Text(
                    //               'Data',
                    //               style: TextStyle(fontSize: 18),
                    //             ),
                    //             Icon(
                    //               Icons.safety_divider,
                    //               size: 35,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(), // Disables swipe gesture
                        controller: _tabController,
                        children: <Widget>[
                          TasksPage(),
                          Center(
                            child: Text('Calendar View'),
                          ),
                          Center(
                            child: Text('Profile'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: TabBar(
                              isScrollable: false,
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: Colors.indigoAccent,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.indigoAccent,
                              indicatorWeight: 0.1,
                              splashFactory: NoSplash.splashFactory,
                              tabs: const <Widget>[
                                Tab(
                                  icon: Icon(Icons.check_box, size: 25),
                                ),
                                Tab(
                                  icon: Icon(Icons.calendar_month_rounded, size: 25),
                                ),
                                Tab(
                                  icon: Icon(Icons.settings, size: 25),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 75,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
