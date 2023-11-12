import 'package:dmart_android_flutter/domain/controllers/user_controller.dart';
import 'package:dmart_android_flutter/presentations/views/home_view_fragments/views/home_fragment/home_fragment.dart';
import 'package:dmart_android_flutter/presentations/views/home_view_fragments/views/profile_fragment.dart';
import 'package:dmart_android_flutter/presentations/widgets/language_change.dart';
import 'package:dmart_android_flutter/presentations/widgets/theme_switch.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserController userController = Get.put(UserController());

  Future<void> setupHome() async {
    await userController.getProfile();
  }

  @override
  void initState() {
    super.initState();
    setupHome();
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),
    ProfileFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                const ThemeSwitch(),
                const SizedBox(
                  width: 16,
                ),
                LanguageChange(triggerUpdate: () {
                  setState(() {});
                }),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: language["home"],
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: language["profile"],
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
