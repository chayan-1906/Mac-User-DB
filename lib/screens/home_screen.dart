import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mac_demo_app/screens/add_user_screen.dart';
import 'package:macos_ui/macos_ui.dart';

import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<UserModel> userBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box('user_box');
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text('Home'),
        titleWidth: 100.0,
        actions: [
          ToolBarIconButton(
            label: 'New User',
            icon: const MacosIcon(CupertinoIcons.add_circled),
            showLabel: false,
            tooltipMessage: 'Add New User',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const AddUserScreen();
                }),
              );
            },
          ),
          ToolBarIconButton(
            label: 'ShowHideSidebar',
            icon: const MacosIcon(CupertinoIcons.shuffle_thick),
            showLabel: false,
            tooltipMessage: 'Show and hide sidebar',
            onPressed: () {
              MacosWindowScope.of(context).toggleSidebar();
            },
          ),
          ToolBarPullDownButton(
            label: 'Export',
            icon: CupertinoIcons.ellipsis_circle,
            items: [
              MacosPulldownMenuItem(
                label: 'PDF',
                title: const Text('PDF'),
                onTap: () {
                  debugPrint('Export to PDF');
                },
              ),
              MacosPulldownMenuItem(
                label: 'Excel',
                title: const Text('Excel'),
                onTap: () {
                  debugPrint('Export to Excel');
                },
              ),
              MacosPulldownMenuItem(
                label: 'Image',
                title: const Text('Image'),
                onTap: () {
                  debugPrint('Export to Image');
                },
              ),
            ],
          ),
        ],
      ),
      children: [
        ContentArea(builder: (context, scrollController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: userBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    final UserModel user = userBox.get(index) as UserModel;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name),
                            Text(user.lastName),
                            Text(user.gender),
                            Text(user.email),
                            Text(user.phone),
                            Text(user.address),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
