import 'package:flutter/material.dart';
import 'package:sepah/Page/Marketing/add_market.dart';
import 'package:sepah/Page/Marketing/all_marketing.dart';

import 'GoogleMap/google_map.dart';
import 'my_marketing.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  TabController? controllerTab;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 10.0,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            controller: controllerTab,
            tabs: const [
              Tab(text: "بازاریابی من"),
              Tab(text: "تمامی بازاریابی ها"),
            ],
          ),
        ),
        body: TabBarView(controller: controllerTab, children: const [
          MyMarketing(),
          AllMarket(),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          child: const Center(
            child: Icon(Icons.add, size: 30.0),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GoogleMapSelect(),
                ));
          },
        ),
      ),
    );
  }
}
