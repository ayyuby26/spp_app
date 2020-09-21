import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp_app/bloc/account/account_bloc.dart';
import 'package:spp_app/ui/login/login_body.dart';
import 'package:spp_app/utils/show_dialog.dart';
import 'package:spp_app/utils/snack_bar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "scf");
  final _loading = GlobalKey<FormState>(debugLabel: "loading");

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

    final _listener = BlocListener<AccountBloc, AccountState>(
      listener: (_, state) {
        if (state is AccountIsValid) {
          Get.back();
          Get.offNamed(
            "/dashboard",
            arguments: state.login,
          );
        }
        if (state is AccountIsLoading)
          loadingDialog(_, _loading);
        else if (state is AccountIsWrong) {
          Get.back();
          snackBar(
            _scaffoldKey,
            "username/password salah",
          );
        } else if (state is AccountNotLogin) {
          Get.back();
          snackBar(
            _scaffoldKey,
            "Tidak dapat terhubung ke server",
          );
        }
      },
      child: Container(),
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
                LoginBody(),
                _listener,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
