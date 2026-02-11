import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ui_controller.dart';
import 'dashboard_view.dart';
import 'collection_view.dart';
import 'Customers.dart';
import 'loan_screen.dart';
import 'more_screen.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  final BottomNavController controller =
  Get.put(BottomNavController());

  final NotchBottomBarController notchController =
  NotchBottomBarController(index: 0);

  final pages = const [
    DashboardView(),
    CollectionsView(),
    CustomersView(),
    LoansScreen(),
    OtherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      notchController.index = controller.currentIndex.value;
      return Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),

        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: notchController,

          kIconSize: 24.0,
          kBottomRadius: 30.0,

          color: const Color(0xFF2F2F2F),
          notchColor: Colors.orange,
          showLabel: false,

          removeMargins: false,
          bottomBarWidth: MediaQuery.of(context).size.width,
          durationInMilliSeconds: 300,

          itemLabelStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),

          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(Icons.home, color: Colors.white70),
              activeItem: Icon(Icons.home, color: Colors.white),
              itemLabel: 'Home',
            ),
            BottomBarItem(
              inActiveItem:
              Icon(Icons.receipt_long, color: Colors.white70),
              activeItem:
              Icon(Icons.receipt_long, color: Colors.white),
              itemLabel: 'Collections',
            ),
            BottomBarItem(
              inActiveItem:
              Icon(Icons.person_outline, color: Colors.white70),
              activeItem:
              Icon(Icons.person, color: Colors.white),
              itemLabel: 'Customers',
            ),
            BottomBarItem(
              inActiveItem:
              Icon(Icons.account_balance, color: Colors.white70),
              activeItem:
              Icon(Icons.account_balance, color: Colors.white),
              itemLabel: 'Loans',
            ),
            BottomBarItem(
              inActiveItem:
              Icon(Icons.more_horiz, color: Colors.white70),
              activeItem:
              Icon(Icons.more_horiz, color: Colors.white),
              itemLabel: 'More',
            ),
          ],

          onTap: (index) {
            controller.changeIndex(index);
          },
        ),
      );
    });
  }
}
