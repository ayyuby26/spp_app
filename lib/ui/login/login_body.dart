import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spp_app/bloc/account/account_bloc.dart';

import 'login_decor.dart';

class LoginBody extends StatelessWidget {
  final _userField = TextEditingController(text: "fulan");
  final _passField = TextEditingController(text: "123");

  final _userFocus = FocusNode();
  final _passFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _title = Text(
      "Login Pembayaran SPP",
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );

    return Container(
      margin: EdgeInsets.only(left: 50, right: 50),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          _title,
          SizedBox(height: 20),
          TextFormField(
            focusNode: _userFocus,
            controller: _userField,
            decoration: loginDecor(Decor.user),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            focusNode: _passFocus,
            controller: _passField,
            decoration: loginDecor(Decor.pass),
            textInputAction: TextInputAction.done,
            onEditingComplete: () => FocusScope.of(context).unfocus(),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            height: 55,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              color: Colors.lightBlue,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onPressed: () => context.bloc<AccountBloc>().add(
                    AccountBlocEvent(
                      _userField.text,
                      _passField.text,
                    ),
                  ),
            ),
          ),
          SizedBox(height: 140),
        ],
      ),
    );
  }
}
