import 'package:flutter/material.dart';
import 'package:inventorymanagement/common/constant/assets.dart';
import 'package:inventorymanagement/feature/home/ui/screen/home.dart';
import 'package:inventorymanagement/feature/items/ui/screen/items.dart';
import 'package:inventorymanagement/feature/menus/menus.dart';
import 'package:inventorymanagement/feature/notification/ui/screen/notification.dart';
import 'package:inventorymanagement/feature/profile/screen/ui/profile_screen.dart';
import 'package:inventorymanagement/feature/search/ui/screen/search_page.dart';

class DashbaordScreen extends StatefulWidget {
  final int initialIndex;

  const DashbaordScreen({super.key, this.initialIndex = 0});

  @override
  State<DashbaordScreen> createState() => _DashbaordScreenState();
}

class _DashbaordScreenState extends State<DashbaordScreen> {
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  late int _currentIndex;
  final screens = [
    const HomePage(),
    const Items(),
    const Menus(),
    const NotificationScreen(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF2E2126),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white,

        selectedLabelStyle:
            TextStyle(height: 2.5, fontSize: 12), // default is ~1.0
        unselectedLabelStyle: TextStyle(height: 2.5, fontSize: 12),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.dashboard,
              color: _currentIndex == 0 ? Colors.redAccent : Colors.white,
              width: 20,
              height: 20,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.item_icon,
              color: _currentIndex == 1 ? Colors.redAccent : Colors.white,
              width: 20,
              height: 20,
            ),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.menu,
              color: _currentIndex == 2 ? Colors.redAccent : Colors.white,
              width: 20,
              height: 20,
            ),
            label: 'Menus',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.notification_icon,
              color: _currentIndex == 3 ? Colors.redAccent : Colors.white,
              width: 20,
              height: 20,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.user,
              color: _currentIndex == 4 ? Colors.redAccent : Colors.white,
              width: 20,
              height: 20,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
