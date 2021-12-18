import 'package:flutter/material.dart';

import '../constants.dart';
import 'tab_my_gallery.dart';
import 'tab_settings.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController pageController = PageController();
  int currentPage = 0;

  final titles = [
    'My gallery',
    'Settings',
  ];

  void onPageChanged(int page) {
    pageController.jumpToPage(page);

    updateCurrentPage(page);
  }

  void updateCurrentPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentPage]),
      ),
      body: Row(
        children: [
          if (width > kMobileBreakpoint)
            NavigationRail(
              selectedIndex: currentPage,
              onDestinationSelected: onPageChanged,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.home_rounded),
                  label: Text(titles[0]),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings_rounded),
                  label: Text(titles[1]),
                )
              ],
            ),
          if (width > kMobileBreakpoint)
            const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: updateCurrentPage,
              children: const [
                MyGalleryView(),
                SettingsView(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: width > kMobileBreakpoint
          ? null
          : BottomNavigationBar(
              onTap: onPageChanged,
              currentIndex: currentPage,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_rounded),
                  label: titles[0],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings_rounded),
                  label: titles[1],
                )
              ],
            ),
    );
  }
}
