import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isuzu/ui/pages/category.dart';
import 'package:isuzu/ui/pages/user.dart';
import 'package:isuzu/ui/pages/home.dart';
import 'package:isuzu/ui/shared/theme.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 60,
            elevation: 0,
            indicatorColor: isuzu50,
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            selectedIndex: controller._selectedIndex.value,
            onDestinationSelected: (int index) {
              controller._selectedIndex.value = index;
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                label: 'Beranda',
                selectedIcon: Icon(Icons.home_filled, color: isuzu500),
              ),
              NavigationDestination(
                icon: const Icon(Icons.list_alt_rounded),
                label: 'Pengecekan',
                selectedIcon: Icon(Icons.list_alt_sharp, color: isuzu500),
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline),
                label: 'Pengguna',
                selectedIcon: Icon(Icons.person, color: isuzu500),
              ),
            ],
          ),
        ),
        body: Obx(() => controller.screen[controller._selectedIndex.value]));
  }
}

class NavigationController extends GetxController {
  final Rx<int> _selectedIndex = 0.obs;

  final screen = [
    const HomePage(),
    const CategoryPage(),
    const UserPage()
  ];
}
