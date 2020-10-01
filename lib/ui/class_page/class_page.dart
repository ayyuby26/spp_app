import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp_app/bloc/class_data/classdata_bloc.dart';
import 'package:spp_app/ui/class_page/class_page_dialog.dart';
import 'package:spp_app/ui/class_page/class_Page_process.dart';
import 'package:spp_app/utils/show_dialog.dart';
import 'package:spp_app/utils/snack_bar.dart';

class ClassPage extends StatefulWidget {

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
    final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "scaffKey");
  final _delete = GlobalKey<FormState>(debugLabel: "delete");

  listener() {
    // ignore: close_sinks
    final _class = context.bloc<ClassdataBloc>();
    return BlocListener<ClassdataBloc, ClassdataState>(
      listener: (_, v) {
        /// CLASS DATA DELETE
        if (v is ClassdataDeleteLoading)
          loadingDialog(_, _delete);
        else if (v is ClassdatadeleteSuccess) {
          Get.back();
          snackBar(_scaffoldKey, v.message);
          _class.add(ClassdataBlocEvent());
        } else if (v is ClassdataDeleteFailed) {
          Get.back();
          errorDialog(_);
        }

        ///CLASS DATA UPDATE
        else if (v is ClassdataUpdateLoading)
          loadingDialog(_, _delete);
        else if (v is ClassdataUpdateSuccess) {
          Get.back();
          snackBar(_scaffoldKey, "berhasil memperbarui data");
          _class.add(ClassdataBlocEvent());
        } else if (v is ClassdataUpdateFailed) {
          Get.back();
          snackBar(_scaffoldKey, "data tidak diperbarui");
          _class.add(ClassdataBlocEvent());
        } else if (v is ClassdataUpdateQueryError) {
          Get.back();
          snackBar(_scaffoldKey, "Kueri bermasalah");
        } else if (v is ClassdataUpdateServerError) {
          Get.back();
          snackBar(_scaffoldKey, "Server bermasalah");
        }

        /// CLASS DATA ADD
        else if (v is ClassdataAddLoading)
          loadingDialog(_, _delete);
        else if (v is ClassdataAddSucces) {
          //if (_delete.currentContext != null)
          Get.back();
          snackBar(_scaffoldKey, "berhasil menambah kelas");
          _class.add(ClassdataBlocEvent());
        } else if (v is ClassdataAddFailed) {
          Get.back();
          snackBar(_scaffoldKey, "Gagal menambah kelas");
        } else if (v is ClassdataAddServerError) {
          Get.back();
          snackBar(_scaffoldKey, "Gagal menambah kelas, server bermasalah");
          _class.add(ClassdataBlocEvent());
        }
      },
      child: SizedBox(),
    );
  }

  data() => BlocBuilder<ClassdataBloc, ClassdataState>(
        builder: (_, v) {
          List<DataRow> listDataRow = [];
          listDataRow.clear();

          if (v is ClassdataLoading)
            return Center(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Text(
                  "loading...",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          else if (v is ClassdataLoaded) {
            listDataRow = classdataProcess(v.data, _scaffoldKey, _);
            return classdataTable(v.data, listDataRow, context);
          }
          return Container();
        },
      );

  @override
  Widget build(BuildContext context) {
    final float = FloatingActionButton(
      heroTag: "tambah soal",
      child: Icon(
        Icons.add,
        size: 30,
      ),
      tooltip: "Tambah Soal",
      onPressed: () => ClassPageDialog.addEditDialog(context),
    );

   

    return Scaffold(
      appBar: AppBar(
        title: Text("Data Kelas"),
        centerTitle: true,
      ),
      floatingActionButton: float,
      key: _scaffoldKey,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              data(),
              listener(),
            ],
          ),
        ),
      ),
    );
  
  }
}



