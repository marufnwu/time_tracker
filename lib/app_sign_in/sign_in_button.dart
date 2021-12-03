import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/common_widget/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
     required String text, double? height, double? borderRadius, Color? color, VoidCallback? onPress,
      Key? key, Color? textColor})
      : super(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(text, style: TextStyle(
                color: textColor??Colors.black,
              fontWeight: FontWeight.w500
            ),
            ),
          ),
          height: height,
          borderRadius: borderRadius,
          color: color,
          onPress: onPress,
        );
}
