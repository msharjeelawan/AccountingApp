import 'package:flutter/material.dart';
import 'package:travel_accounting/Helper/Constant.dart';
import 'package:travel_accounting/Views/dashboard_screen.dart';
import 'package:travel_accounting/Views/menus_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{
  var tabs = ["Dashboard","Menus"];
  late TabController tabController;

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main"),
      //  centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/setting');
              },
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: TabBarView(
        controller: tabController,
          children: const [
            DashboardScreen(),
            MenusScreen(),
          ]
      ),
      bottomNavigationBar: BottomAppBar(
        color: primaryColor1,
        child: TabBar(
          // overlayColor: MaterialStateProperty.all(primaryColor1),
            indicatorColor: white,
            indicatorWeight: 4,
            controller: tabController,
            tabs: tabs.map((tab) {
              return Tab(text: tab);
            }).toList()
        ),
      ),
      // bottomNavigationBar: ,
    );
  }
}
