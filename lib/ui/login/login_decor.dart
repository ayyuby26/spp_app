import 'package:flutter/material.dart';

enum Decor { user, pass }
loginDecor(Decor decor) => InputDecoration(
      prefixIcon: Icon(
        decor == Decor.user ? Icons.account_circle : Icons.lock,
        color: Colors.blue,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: Colors.black38,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: Colors.blue,
          style: BorderStyle.solid,
        ),
      ),
      hintText: decor == Decor.user ? "Masukkan username" : "Masukkan password",
      hintStyle: TextStyle(color: Colors.black26),
    );
