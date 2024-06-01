

import 'package:flutter/material.dart';

class ColorConstants {
  static Color white = hexToColor('#F8F8F8');
  static Color oneCBA = hexToColor('#1CBA19');
  static Color oneZero = hexToColor('#101010');
  static Color fourZero = hexToColor('#404040');
  static Color bbTwoFive = hexToColor('#BB2531');
  static Color zeroFiveNineD = hexToColor('#059D14');
  static Color sixOneOneThree = hexToColor('#611318');
  static Color fiveFiveOneOne = hexToColor('#551116');
}

Color hexToColor(String hex) {
  assert(
  RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
  'hex color must be #rrggbb or #rrggbbaa',
  );

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class CommonDecorations {
  static BoxDecoration commonTextFieldDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: ColorConstants.bbTwoFive,
      ),
    );
  }

  static BoxDecoration whiteTextFieldDecoration() {
    return BoxDecoration(
      color: ColorConstants.white,
      borderRadius: BorderRadius.circular(8),
    );
  }

  static InputDecoration commonLoginDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      hintText: hintText,
      hintStyle: TextStyle(
        color: ColorConstants.fourZero.withOpacity(0.4),
        fontSize: 16,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );
  }

  static Decoration gradientRedDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          ColorConstants.bbTwoFive,
          ColorConstants.fiveFiveOneOne,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: const [0, 1],
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32.0),
        topRight: Radius.circular(32.0),
      ),
    );
  }

  static Decoration appBarRedDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorConstants.sixOneOneThree,
          ColorConstants.bbTwoFive,
        ],
      ),
    );
  }

  static InputDecoration profileTextFormFieldDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.all(10),
      hintText: hintText,
      hintStyle: TextStyle(color: ColorConstants.fourZero.withOpacity(0.4)),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorConstants.bbTwoFive, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
    );
  }

  static BoxDecoration bgPhotoDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: const DecorationImage(
        image: AssetImage(
          'assets/png/point_list_bg.png',
        ),
        fit: BoxFit.cover,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, 2),
          blurRadius: 2,
        ),
      ],
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.contentWidget,
  });

  final Widget contentWidget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              ColorConstants.bbTwoFive,
              ColorConstants.sixOneOneThree,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [0, 1],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: ColorConstants.white,
          ),
          margin: const EdgeInsets.all(2),
          padding:
          const EdgeInsets.only(left: 18, right: 18, top: 34, bottom: 14),
          child: contentWidget,
        ),
      ),
    );
  }
}
