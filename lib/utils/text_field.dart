  import 'package:flutter/material.dart';

decorTextFieldLogin([_]) {
    return InputDecoration(
      prefixIcon: Icon(
        _ == null ? Icons.account_circle : Icons.lock,
        color: Colors.blue,
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide:
              BorderSide(color: Colors.black38, style: BorderStyle.solid)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid)),
      hintText: _ == null ? "Masukkan username" : "Masukkan password",
      hintStyle: TextStyle(color: Colors.black26),
    );
  }