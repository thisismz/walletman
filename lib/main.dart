import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:walletman/ui/pages/transaction_list_page.dart';
import 'package:walletman/ui/pages/statistics_page.dart';
import 'package:walletman/ui/pages/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    ));

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          ManagerPage(),
          StatisticsPage(),
          TransactionListPage()
        ],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        color: Color(0xFF2d3447),
        child: TabBar(
          tabs: <Tab>[
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF232937),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF374056), width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(FontAwesomeIcons.wallet),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF232937),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF374056), width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(FontAwesomeIcons.chartPie),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF232937),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF374056), width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(FontAwesomeIcons.exchangeAlt),
                  ),
                ),
              ),
            ),
          ],
          indicatorWeight: 5,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: EdgeInsets.only(top: 5, left: 5, right: 5),
          controller: controller,
        ),
      ),
    );
  }
}
