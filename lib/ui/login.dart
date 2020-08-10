import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp/bloc/account/account_bloc.dart';
import 'package:spp/ui/dashboard.dart';
import 'package:spp/utils/show_dialog.dart';
import 'package:spp/utils/snack_bar.dart';
import 'package:spp/utils/text_field.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "login.dart");

  bool success = false;
  final TextEditingController _userField = TextEditingController(text: "fulan");
  final TextEditingController _passField = TextEditingController(text: "123");

  final FocusNode _userFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  GlobalKey<FormState> _loading =
      GlobalKey<FormState>(debugLabel: "_loading - loagin.dart");
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AccountBloc accountBloc = BlocProvider.of<AccountBloc>(context);
    // if (success) Get.off(Dashboard());
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                    child: Container(
                  // color: Colors.amber,
                  child: FlareActor(
                    "assets/WorldSpin.flr",
                    fit: BoxFit.contain,
                    animation: "roll",
                  ),
                  height: 250,
                  width: 250,
                )),
                Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Login Pembayaran SPP",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        focusNode: _userFocus,
                        controller: _userField,
                        decoration: decorTextFieldLogin(),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        focusNode: _passFocus,
                        controller: _passField,
                        decoration: decorTextFieldLogin("i"),
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
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
                          onPressed: () {
                            // Get.off(Dashboard());
                            accountBloc.add(AccountBlocEvent(
                                _userField.text, _passField.text));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 140,
                      ),
                      BlocListener<AccountBloc, AccountState>(
                        listener: (_, state) {
                          if (state is AccountIsValid) {
                            Future.delayed(Duration(milliseconds: 200))
                                .whenComplete(() {
                              Navigator.pop(_loading.currentContext);
                              Get.off(Dashboard());
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
                            snackBar(_scaffoldKey,
                                "Tidak dapat terhubung ke server");
                          }
                        },
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
