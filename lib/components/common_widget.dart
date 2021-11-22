import 'package:flutter/material.dart';

class ShowSnackBar {
  final BuildContext context;
  final String text;
  ShowSnackBar(this.context, this.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: "Ok",
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }
}

class IsLoading {
  final BuildContext context;
  IsLoading(this.context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator()),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }
}
