import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spp_app/bloc/class_data/classdata_bloc.dart';
import 'package:spp_app/bloc/student/student_bloc.dart';
import 'package:spp_app/ui/class_page/class_page.dart';
import 'package:spp_app/ui/dashboard.dart';
import 'package:spp_app/ui/login/login.dart';
import 'package:spp_app/ui/student_page/student_page.dart';
import 'bloc/account/account_bloc.dart';
import 'package:get/src/navigation/routes/transitions_type.dart' as tr;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _cup = tr.Transition.cupertino;
  @override
  Widget build(BuildContext context) {
    final _getPages = [
      GetPage(name: '/', page: () => Login()),
      GetPage(name: '/dashboard', page: () => Dashboard()),
      GetPage(name: '/class', page: () => ClassPage(), transition: _cup),
      GetPage(name: '/student', page: () => StudentPage(), transition: _cup),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(create: (_) => AccountBloc()),
        BlocProvider<ClassdataBloc>(create: (_) => ClassdataBloc()),
        BlocProvider<StudentBloc>(create: (_) => StudentBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        getPages: _getPages,
      ),
    );
  }
}
