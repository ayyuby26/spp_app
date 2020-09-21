import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp_app/bloc/account/account_bloc.dart';
import 'package:spp_app/utils/show_dialog.dart';
import 'package:spp_app/utils/snack_bar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "scf");
  final _loading = GlobalKey<FormState>(debugLabel: "loading");

  final _userField = TextEditingController(text: "fulan");
  final _passField = TextEditingController(text: "123");

  final _userFocus = FocusNode();
  final _passFocus = FocusNode();

  _decoration([_]) => InputDecoration(
        prefixIcon: Icon(
          _.isNull ? Icons.account_circle : Icons.lock,
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
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.blue,
            style: BorderStyle.solid,
          ),
        ),
        hintText: _.isNull ? "Masukkan username" : "Masukkan password",
        hintStyle: TextStyle(color: Colors.black26),
      );

  @override
  Widget build(BuildContext context) {
    final _logo = Center(
      child: Container(
        child: FlareActor(
          "assets/WorldSpin.flr",
          fit: BoxFit.contain,
          animation: "roll",
        ),
        height: 250,
        width: 250,
      ),
    );

    // ignore: close_sinks
    final accountBloc = BlocProvider.of<AccountBloc>(context);

    final _body = Container(
      margin: EdgeInsets.only(left: 50, right: 50),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Text(
            "Login Pembayaran SPP",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            focusNode: _userFocus,
            controller: _userField,
            decoration: _decoration(),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            focusNode: _passFocus,
            controller: _passField,
            decoration: _decoration("_"),
            textInputAction: TextInputAction.done,
            onEditingComplete: () => FocusScope.of(context).unfocus(),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            height: 55,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.lightBlue,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () => accountBloc
                  .add(AccountBlocEvent(_userField.text, _passField.text)),
            ),
          ),
          SizedBox(height: 140),
          BlocListener<AccountBloc, AccountState>(
            listener: (_, state) {
              if (state is AccountIsValid) {
                Future.delayed(Duration(milliseconds: 200)).whenComplete(() {
                  Navigator.pop(_loading.currentContext);
                  Get.offNamed("/dashboard", arguments: state.login);
                });
              }
              if (state is AccountIsLoading) {
                loadingDialog(_, _loading, state);
              } else if (state is AccountIsWrong) {
                if (_loading.currentContext != null) {
                  Navigator.pop(_loading.currentContext);
                  snackBar(_scaffoldKey, "username/password salah");
                }
              } else if (state is AccountNotLogin) {
                Navigator.pop(_loading.currentContext);
                snackBar(_scaffoldKey, "Tidak dapat terhubung ke server");
              }
            },
            child: SizedBox(),
          )
        ],
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _logo,
                _body,
                // Get.off(Dashboard());
              ],
            ),
          ),
        ),
      ),
    );
  }
}
