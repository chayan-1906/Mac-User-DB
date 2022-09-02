import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_demo_app/screens/account_screen.dart';
import 'package:mac_demo_app/screens/home_screen.dart';
import 'package:mac_demo_app/screens/product_screen.dart';
import 'package:mac_demo_app/screens/settings_screen.dart';
import 'package:macos_ui/macos_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const ProductScreen(),
    const AccountScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        top: MacosSearchField(
          placeholder: 'Search...',
          results: const [
            'Apple',
            'Boy',
            'Cat',
            'Dog',
            'Egg',
            'Fish',
            'Ball',
          ].map((e) => SearchResultItem(e)).toList(),
          maxResultsToShow: 3,
          onResultSelected: (value) {
            print(value.searchKey);
          },
        ),
        builder: ((context, scrollController) {
          return SidebarItems(
            items: const [
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.home),
                selectedColor: Colors.greenAccent,
                label: Text('Home'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.cart),
                selectedColor: Colors.greenAccent,
                label: Text('Product'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.person),
                selectedColor: Colors.greenAccent,
                label: Text('Account'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.settings_solid),
                selectedColor: Colors.greenAccent,
                label: Text('Settings'),
              ),
            ],
            currentIndex: currentIndex,
            onChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
          );
        }),
        minWidth: 200.0,
        startWidth: 200.0,
        maxWidth: 350.0,
        bottom: Row(
          children: const [
            MacosIcon(CupertinoIcons.person),
            Text('demo@gmail.com'),
          ],
        ),
      ),
      child: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
