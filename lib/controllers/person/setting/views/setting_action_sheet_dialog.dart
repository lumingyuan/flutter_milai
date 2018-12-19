import 'package:flutter_milai/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///actions 格式为
/// [{"title":"", "value":..} ...]
///
Future<dynamic> showActionSheetDialog(
    BuildContext context, String title, List<Map> actions) async {
  List<Widget> actionWidgets = new List();
  for (Map action in actions) {
    actionWidgets.add(CupertinoActionSheetAction(
      onPressed: () {
        Navigator.of(context).pop(action['value']);
      },
      isDestructiveAction: false,
      child: Text('${action['title']}'),
    ));
  }

  return await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: actionWidgets,
          message: title == null ? null : Text('$title'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('取消'),
            isDestructiveAction: true,
          ),
        );
      });
}
