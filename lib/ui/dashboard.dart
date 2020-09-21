import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spp_app/bloc/class_data/classdata_bloc.dart';
import 'package:spp_app/bloc/student/student_bloc.dart';
import 'package:spp_app/models/account.dart';
import 'package:spp_app/utils/menus.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  final _lastName = (Get.arguments as Account).fullName.split(" ").last;
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async =>
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Get.back(result: false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Get.back(result: true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;

    final _topWidget = Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          child: FlatButton(
            onPressed: () {
              // BlocProvider.of<LoginBloc>(context).add(
              //   ResetLogin(),
              // );
              Get.offNamed("/");
            },
            child: Text("Logout"),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25, top: 25),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Selamat datang, " + _lastName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );

    _iconTextMenus(int i) => Column(
          children: <Widget>[
            SizedBox(height: 25),
            SvgPicture.asset(Items.myList[i].img, height: 80),
            SizedBox(height: 10),
            Text(
              Items.myList[i].title,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );

    void _onClick(int i) {
      switch (i) {
        case 0:
          {
            context.bloc<ClassdataBloc>().add(ClassdataBlocEvent());
            Get.toNamed("/class");
          }
          break;
        case 1:
          {
            context.bloc<StudentBloc>().add(StudentBlocEvent());
            Get.toNamed("/student");
          }
          break;
        case 2:
          {}
          break;
        case 3:
          {}
          break;
        case 4:
          {}
          break;
      }
    }

    final _menus = Flexible(
      child: GridView.builder(
        padding: EdgeInsets.all(20),
        itemCount: Items.myList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
        ),
        itemBuilder: (_, i) => Container(
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(10),
            shadowColor: Colors.white,
            elevation: 5,
            color: Colors.white,
            child: InkWell(
              highlightColor: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(10),
              radius: 20,
              splashColor: Colors.white,
              child: _iconTextMenus(i),
              onTap: () async => _onClick(i),
            ),
          ),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            _topWidget,
            SizedBox(height: 1),
            _menus,
          ],
        ),
      ),
    );
  }
}
