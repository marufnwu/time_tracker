import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/common_widget/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
     required String text, Color? textColor, double? height, double? borderRadius, required String imageName,Color? color, VoidCallback? onPress,
      Key? key})
      : super(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                    imageName,
                ),
                Text(text, style: TextStyle(
                    color: textColor ?? Colors.black,
                    fontWeight: FontWeight.w500
                ),
                ),
                Opacity(
                  opacity: 0.0,
                    child: Image.asset(imageName)
                ),

              ],
            )
          ),
          height: height,
          borderRadius: borderRadius,
          color: color,
          onPress: onPress,
        );
}
