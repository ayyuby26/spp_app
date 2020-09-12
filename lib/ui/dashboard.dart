import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spp_app/bloc/class_data/classdata_bloc.dart';
import 'package:spp_app/ui/class_data_view.dart';
import 'package:spp_app/ui/login.dart';
import 'package:spp_app/utils/menus.dart';

class Dashboard extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => Dashboard());
  }

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var color = 0xff453658;
  @override
  Widget build(BuildContext context) {

    // ignore: close_sinks
    final ClassdataBloc classdataBloc = BlocProvider.of<ClassdataBloc>(context);

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App'),
              actions: <Widget>[
                 FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child:  Text('No'),
                ),
                 FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child:  Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      // BlocProvider.of<LoginBloc>(context).add(
                      //   ResetLogin(),
                      // );
                      Get.off(Login());
                    },
                    child: Text("Logout"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, top: 25),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Selamat datang,"
                    //  +
                    //     (account.user == null
                    //         ? "empty"
                    //         : account.fullName
                    //             .substring(account.fullName.lastIndexOf(" ")))
                    ,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Flexible(
                child: GridView.builder(
              padding: EdgeInsets.all(20),
              itemCount: myList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
              ),
              itemBuilder: (_, i) => Container(
                  decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                              ),
                              SvgPicture.asset(
                                myList[i].img,
                                height: 80,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                myList[i].title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {
                            switch (i) {
                              case 0:
                                {
                                  classdataBloc.add(ClassdataBlocEvent());
                                  Get.to(ClassDataView());
                                }
                                break;
                              case 1:
                                {}
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
                          }))),
            )),
          ],
        ),
      ),
    );
  }
}
