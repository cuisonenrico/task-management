import 'package:flutter/material.dart';
import 'package:task_management/screens/widgets/custom_expansion_tile.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomExpansionTile(
                expandedChildren: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8.0,
                    children: [
                      Icon(
                        Icons.disabled_by_default_outlined,
                        size: 35,
                      ),
                      Icon(
                        Icons.disabled_by_default_outlined,
                        size: 35,
                      ),
                      Icon(
                        Icons.disabled_by_default_outlined,
                        size: 35,
                      ),
                      Icon(
                        Icons.disabled_by_default_outlined,
                        size: 35,
                      ),
                      Icon(
                        Icons.disabled_by_default_outlined,
                        size: 35,
                      ),
                    ],
                  ),
                ],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.safety_check,
                      size: 35,
                    ),
                    Text(
                      'Data',
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(
                      Icons.safety_divider,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  Center(
                    child: Text('TODO Tasks'),
                  ),
                  Center(
                    child: Text('Calendar View'),
                  ),
                  Center(
                    child: Text('Profile'),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(icon: Icon(Icons.check_box)),
                Tab(icon: Icon(Icons.calendar_month_rounded)),
                Tab(icon: Icon(Icons.person)),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
