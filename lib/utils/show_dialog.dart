import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp/bloc/class_data/classdata_bloc.dart';

loadingDialog(_, GlobalKey<FormState> _alert, state) {
  // if (state is IsNotLogin) {
  //   Navigator.pop(_);
  // }
  return showDialog(
      context: _,
      builder: (_) {
        return CupertinoAlertDialog(
            key: _alert,
            content: Center(
                child: Column(
              children: <Widget>[
                Container(
                  // color: Colors.amber,
                  child: FlareActor(
                    "assets/Loader.flr",
                    fit: BoxFit.contain,
                    animation: "Loading",
                  ),
                  height: 150,
                  width: 150,
                ),
              ],
            )));
      });
}

deleteDialog(GlobalKey<ScaffoldState> _scaffoldKey, BuildContext context,
    String content, String id) {
  // ignore: close_sinks
  final deleteDatakelasBloc = BlocProvider.of<ClassdataBloc>(context);

  showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text("Konfirmasi hapus"),
          content: Container(
              padding: EdgeInsets.only(top: 15), child: Text(content)),
          actions: <Widget>[
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(_);
                },
                isDefaultAction: false,
                child: Text("Batal")),
            CupertinoDialogAction(
                onPressed: () {
                  deleteDatakelasBloc.add(ClassdataDeleteBlocEvent(id));
                  Navigator.pop(_);
                },
                textStyle: TextStyle(color: Colors.red),
                isDefaultAction: true,
                child: Text("Hapus")),
          ],
        );
      });
}

errorDialog(_) {
  showDialog(
      context: _,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text("Kesalahan ditemukan"),
          content: Container(
              padding: EdgeInsets.only(top: 15),
              child: Text("Tidak dapat terhubung ke server")),
          actions: <Widget>[
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(_);
                },
                isDefaultAction: true,
                child: Text("Tutup")),
          ],
        );
      });
}

editDialog(BuildContext _, String id, String classLevel, String majors, String classCode) {
  final classLevelController = TextEditingController(text: classLevel);
  final majorsController = TextEditingController(text: majors);
  final classCodeController = TextEditingController(text: classCode);
  showDialog(
      context: _,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text("Ubah Data"),
          content: Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                CupertinoTextField(
                  controller: classLevelController,
                  placeholder: "Kelas",
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoTextField(
                  controller: majorsController,
                  placeholder: "Jurusan",
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoTextField(
                  controller: classCodeController,
                  placeholder: "Kode Kelas",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text("Batal"),
                onPressed: () {
                  Get.back();
                }),
            CupertinoDialogAction(
                isDefaultAction: true, child: Text("Simpan"), onPressed: () {})
          ],
        );
      });
}
