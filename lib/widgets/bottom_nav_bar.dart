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
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isSelected)
              Container(
                height: 6,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.15),
                      blurRadius: 30,
                      spreadRadius: 5, // Adjusted for more visible glow
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(bottom: 6),
              ),
            Icon(icon, size: 20),
            const SizedBox(height: 2),
            Text(text, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70, // Increased height for the nav bar
        color: Colors.black,
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            buildTab(Icons.home, 'Home', 0),
            buildTab(Icons.check_circle, 'Prime', 1),
            buildTab(Icons.subscriptions, 'Subscriptions', 2),
            buildTab(Icons.download, 'Downloads', 3),
            buildTab(Icons.search, 'Search', 4),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          HomeScreen(),
          Center(child: Text('Prime')),
          Center(child: Text('Subscriptions')),
          Center(child: Text('Downloads')),
          Center(child: Text('Search')),
        ],
      ),
    );
  }
}
