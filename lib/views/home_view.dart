import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/records_service.dart';
import 'package:number_connection_test/views/account_view.dart';
import 'package:number_connection_test/views/games_home_view.dart';
import 'package:number_connection_test/views/records_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final RecordsService _recordsService;
  String get userEmail => AuthService.firebase().currentUser!.email;

  @override
  void initState() {
    _recordsService = RecordsService();
    // _recordsService.open(); we don't need this anymore, because we make sure
    // db will open at any RecordsService, aka _ensureDbIsOpen();
    super.initState();
  }

  @override
  void dispose() {
    _recordsService.close();

    super.dispose();
  }

  int _currentIndex = 0; //預設值
  final pages = [
    const GamesHomeView(),
    const RecordsView(),
    const AccountView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
