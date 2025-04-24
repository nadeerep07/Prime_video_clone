import 'package:amazon_prime_clone/screens/downloads_screen.dart';
import 'package:amazon_prime_clone/screens/prime_screen.dart';
import 'package:amazon_prime_clone/screens/search_screen.dart';
import 'package:amazon_prime_clone/screens/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:amazon_prime_clone/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTab(IconData icon, String text, int index) {
    final isSelected = _tabController.index == index;

    return Tab(
      height: 70,
      child: Container(
        width: 70,
        // decoration: BoxDecoration(
        //   gradient:
        //       isSelected
        //           ? LinearGradient(
        //             begin: Alignment.topCenter,
        //             end: Alignment.bottomCenter,
        //             colors: [
        //               Colors.black.withValues(alpha:0.8),
        //               Colors.black.withValues(alpha:0.2),
        //             ],
        //           )
        //           : null,
        //   borderRadius: BorderRadius.circular(8),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Selected tab indicator
            if (isSelected)
              Container(
                height: 2,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(bottom: 6),
              ),
            // Icon with glow effect when selected
            Container(
              decoration:
                  isSelected
                      ? BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 0.1,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.5),
                            blurRadius: 18,
                            spreadRadius: 0.2,
                            offset: const Offset(0, -13),
                          ),
                        ],
                      )
                      : null,
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 6),
            // Text label
            Text(
              text,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A0A), Color(0xFF0A0A0A)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: EdgeInsets.zero,
          tabs: [
            buildTab(Icons.home, 'Home', 0),
            buildTab(Icons.check_circle_outline, 'Prime', 1),
            buildTab(Icons.dashboard_customize_outlined, 'Subscriptions', 2),
            buildTab(Icons.download, 'Downloads', 3),
            buildTab(Icons.search, 'Search', 4),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          HomeScreen(),
          PrimeScreen(),
          SubscriptionScreen(),
          DownloadScreen(),
          SearchScreen(),
        ],
      ),
    );
  }
}
