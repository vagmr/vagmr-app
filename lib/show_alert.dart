import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert showAlert({
  required BuildContext context,
  required AlertType type,
  String? title,
  String? desc,
  bool signleButton = false,
  String confirmText = '确定',
  String cancelText = '取消',
}) {
  return Alert(
      context: context,
      type: type,
      title: title ?? '提示',
      desc: desc,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context, true),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: Text(confirmText,
              style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
        DialogButton(
            onPressed: () => Navigator.pop(context, false),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
            child: Text(
              cancelText,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ))
      ]);
}
