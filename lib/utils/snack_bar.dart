import 'package:flutter/material.dart';

ScaffoldFeatureController snackBar(
    GlobalKey<ScaffoldState> _scaffoldKey, String _content) {
  return _scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(_content),
    // action: SnackBarAction(
    //   label: 'close',
    //   onPressed: () {
    //     Navigator.pop(_scaffoldKey.currentContext);
    //   },
    // ),
  ));
}
