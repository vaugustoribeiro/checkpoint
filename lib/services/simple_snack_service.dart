import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleSnackService {
  static void busy(BuildContext context, String message) {
    var snackbar = SnackBar(
      backgroundColor: Colors.blue,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Container(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(days: 1),
    );

    create(context, snackbar);
  }

  static void success(BuildContext context, String message) {
    var snackbar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );
    create(context, snackbar);
  }

  static void error(BuildContext context, String message) {
    var snackbar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );
    create(context, snackbar);
  }

  static void create(BuildContext context, SnackBar snackbar) {
    clear(context);
    Scaffold.of(context).showSnackBar(snackbar);
  }

  static void clear(context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }
}
