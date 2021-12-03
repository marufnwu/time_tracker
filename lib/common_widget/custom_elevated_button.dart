import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? height;
  final double? borderRadius;
  final VoidCallback? onPress;

  const CustomElevatedButton({Key? key, required this.child, this.color, this.height, this.borderRadius, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?? 40.0,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.all(10),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0.0)
            ),
          ),
          backgroundColor: MaterialStateProperty.all(color ?? Colors.white),
        ),
        child: child,
      ),
    );
  }
}
