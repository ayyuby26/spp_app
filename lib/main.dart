import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spp_app/bloc/class_data/classdata_bloc.dart';
import 'package:spp_app/ui/login.dart';
import 'bloc/account/account_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(create: (context) => AccountBloc(),),
        BlocProvider<ClassdataBloc>(create: (context) => ClassdataBloc(),),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}