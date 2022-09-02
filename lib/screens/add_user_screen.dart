import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mac_demo_app/base/base_text_form_field.dart';
import 'package:macos_ui/macos_ui.dart';

import '../models/user_model.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late Box<UserModel> userBox;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _gender;
  final List<String> _genders = ['M', 'F', 'Other'];
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  // final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  Future<void> addUser() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      final UserModel userModel = UserModel(
        name: firstNameController.text,
        lastName: lastNameController.text,
        gender: _gender.toString(),
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
      );
      final result = await userBox.add(userModel);
      debugPrint(result.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box('user_box');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text('User'),
        titleWidth: 100.0,
        actions: [
          ToolBarIconButton(
            label: 'Save',
            icon: const MacosIcon(CupertinoIcons.person_add),
            showLabel: true,
            tooltipMessage: 'Add New User',
            onPressed: () {
              addUser();
            },
          ),
          ToolBarIconButton(
            label: 'Delete',
            icon: const MacosIcon(CupertinoIcons.delete_solid),
            showLabel: true,
            tooltipMessage: 'Delete a user',
            onPressed: () {
              debugPrint('Delete user');
            },
          ),
        ],
      ),
      children: [
        ContentArea(builder: (context, scrollController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// first name & last name
                    Row(
                      children: [
                        const Text('First Name: '),

                        /// first name
                        BaseTextFormField(
                          textEditingController: firstNameController,
                          // focusNode: focusNode,
                        ),
                        const SizedBox(width: 8.0),
                        const Text('Last Name: '),

                        /// last name
                        BaseTextFormField(
                          textEditingController: lastNameController,
                          // focusNode: focusNode,
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                    const SizedBox(height: 8.0),

                    /// gender & email
                    Row(
                      children: [
                        const Text('Gender: '),

                        /// gender
                        Material(
                          type: MaterialType.transparency,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 24.0,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: _genders.map(buildMenuItem).toList(),
                                value: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const Text('Email: '),

                        /// email
                        BaseTextFormField(
                          textEditingController: emailController,
                          // focusNode: focusNode,
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                    const SizedBox(height: 8.0),

                    /// phone & address
                    Row(
                      children: [
                        const Text('Phone: '),

                        /// phone
                        BaseTextFormField(
                          textEditingController: phoneController,
                          // focusNode: focusNode,
                        ),
                        const SizedBox(width: 8.0),
                        const Text('Address: '),

                        /// address
                        BaseTextFormField(
                          textEditingController: addressController,
                          // focusNode: focusNode,
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
