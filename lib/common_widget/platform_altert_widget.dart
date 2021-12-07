import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker/common_widget/platform_widget.dart';

class PlatformAlertWidget extends PlatformWidget {
   PlatformAlertWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.defaultActionText,
     this.cancelActionText
  }) : super(key: key);

  final String title;
  final String content;
  final String defaultActionText;
  String? cancelActionText;

  Future<bool> show(BuildContext context) async{
    return await showDialog(
        context: context,
        builder: (context)=>this
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    List<Widget> actions =[];
    if(cancelActionText!=null){
      actions.add(PlatformAlertDialogAction(Text(cancelActionText!), (){
        Navigator.of(context).pop(false);
      }));
    }
    actions.add(PlatformAlertDialogAction(Text(defaultActionText), (){
      Navigator.of(context).pop(true);
    }));
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget child;
  final VoidCallback onPress;

  PlatformAlertDialogAction(this.child, this.onPress);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPress,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(
      child: child,
      onPressed: onPress,
    );
  }
}
