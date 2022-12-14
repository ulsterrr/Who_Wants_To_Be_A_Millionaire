import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

customDialogLogout(BuildContext context, String tag, String title, bool color) {
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
            onPressed: () {
              FirebaseAuth.instance.signOut();
              GoogleSignIn().signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            },
            child: Text(
              'Xác nhận',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )
        ],
      );
    },
  );
}

customDialogPass(BuildContext context, String tag, String title) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          tag,
          style:
              TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
        ),
        content: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
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
