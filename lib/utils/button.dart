import 'package:flutter/material.dart';
import 'package:spp_app/bloc/account/account_bloc.dart';

buttonLogin(loginBloc,_userField,_passField) {
  return FlatButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    onPressed: () {
      loginBloc.add(AccountBlocEvent(_userField.text, _passField.text));
    },
    color: Colors.lightBlue,
    child: Text(
      "Login",
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

// buttonLogin(loginBloc,_userField,_passField) {
//   return FlatButton(
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10))),
//     onPressed: () {
//       loginBloc.add(LoginBlocEvent(_userField.text, _passField.text));
//     },
//     color: Colors.lightBlue,
//     child: Text(
//       "Login",
//       style: TextStyle(color: Colors.white, fontSize: 16),
//     ),
//   );
// }
