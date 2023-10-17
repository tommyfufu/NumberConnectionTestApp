import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:number_connection_test/views/account_view.dart';
import 'package:number_connection_test/views/games_home_view.dart';
import 'package:number_connection_test/views/records_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0; //預設值
  // final pages = [
  //   homeRoute,
  //   recordsRoute,
  //   accountRoute,
  // ];
  final pages = [
    const GamesHomeView(),
    const RecordsView(),
    const AccountView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: const Text(
      //     "遊戲大廳",
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 25,
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(MdiIcons.controller), label: '遊戲'),
          BottomNavigationBarItem(icon: Icon(MdiIcons.podium), label: '我的遊戲紀錄'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.faceAgent), label: '會員專區'),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemClick,
      ),
      body: pages[_currentIndex],
    );
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
