import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_nav_controller.dart';
import '../fragments/home_fragment.dart';
import '../fragments/ride_history_fragment.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final DashboardNavController dashboardController =
      Get.put(DashboardNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return IndexedStack(
          index: dashboardController.selectedIndex.value,
          children: [
            HomeFragment(),
            RideHistoryFragment(),
          ],
        );
      }),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            currentIndex: dashboardController.selectedIndex.value,
            onTap: (index) => dashboardController.updateIndex(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.car_rental),
                label: 'Rides',
              ),
            ],
          );
        },
      ),
    );
  }
}
