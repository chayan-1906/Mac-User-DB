import 'package:flutter/cupertino.dart';

BorderSide _kDefaultRoundedBorderSide = const BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  style: BorderStyle.solid,
  width: 0.1,
);

Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);

BoxDecoration kDefaultRoundedBorderDecoration = BoxDecoration(
  color: const CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.white,
    darkColor: CupertinoColors.black,
  ),
  border: _kDefaultRoundedBorder,
  boxShadow: const [
    BoxShadow(
      color: CupertinoDynamicColor.withBrightness(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        darkColor: Color.fromRGBO(255, 255, 255, 0.1),
      ),
      offset: Offset(0, 1),
    ),
  ],
  borderRadius: const BorderRadius.all(Radius.circular(7.0)),
);

const BoxDecoration kDefaultFocusedBorderDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(7.0)),
);