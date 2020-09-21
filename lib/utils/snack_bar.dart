import 'package:flutter/material.dart';

snackBar(GlobalKey<ScaffoldState> _scaffoldKey, String _content) =>
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(_content),
      ),
    );
