import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class BaseTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const BaseTextFormField({
    Key? key,
    required this.textEditingController,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MacosTextField(
        controller: textEditingController,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: kDefaultFocusedBorderDecoration,
      ),
    );
  }
}
