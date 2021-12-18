import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'models/gallery_view_model.dart';
import 'tab_my_gallery.dart';
import 'tab_settings.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GalleryViewModel viewModel;

  PageController pageController = PageController();
  int currentPage = 0;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    viewModel = GalleryViewModel();

    viewModel.storage.streamGallery().listen((event) {
      if (event != null) {
        viewModel.addToMyImages(event);
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
      }
    });
  }

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

  void onPickImage() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    log('${image?.path}');

    if (image != null) {
      viewModel.uploadToStorage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider.value(
        value: viewModel,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(titles[currentPage]),
            ),
            floatingActionButtonLocation:
                MediaQuery.of(context).size.width > kMobileBreakpoint
                    ? FloatingActionButtonLocation.endTop
                    : FloatingActionButtonLocation.centerDocked,
            floatingActionButton: currentPage == 0
                ? FloatingActionButton(
                    child: const Icon(Icons.add_a_photo_rounded),
                    onPressed: onPickImage,
                  )
                : null,
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
        });
  }
}
