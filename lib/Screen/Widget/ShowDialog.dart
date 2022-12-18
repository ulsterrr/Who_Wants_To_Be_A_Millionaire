import 'package:flutter/material.dart';

customDialog(BuildContext context, String tag, String title, bool color) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          tag,
          style: TextStyle(
              color: color == true ? Colors.redAccent : Colors.greenAccent,
              fontWeight: FontWeight.bold),
        ),
        content: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )
        ],
      );
    },
  );
}
