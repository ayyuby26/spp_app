import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spp_app/bloc/class_data/classdata_bloc.dart';
import 'package:spp_app/ui_data/class_data_process.dart';
import 'package:spp_app/utils/show_dialog.dart';
import 'package:spp_app/utils/snack_bar.dart';

class ClassDataView extends StatefulWidget {
  @override
  _ClassDataStateView createState() => _ClassDataStateView();
}

class _ClassDataStateView extends State<ClassDataView> {
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffoldKey classdata");
  final _delete = GlobalKey<FormState>(debugLabel: "delete classdata");
  final _alert = GlobalKey<FormState>(debugLabel: "loading classdata");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: "tambah soal",
          child: Icon(
            Icons.add,
            size: 30,
          ),
          tooltip: "Tambah Soal",
          onPressed: () {
            addDialog(context);
          }),
      key: _scaffoldKey,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                "Data Kelas",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              BlocBuilder<ClassdataBloc, ClassdataState>(builder: (_, v) {
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
                  return classdataTable(listDataRow, context);
                }
                return Container();
              }),
              BlocListener<ClassdataBloc, ClassdataState>(
                listener: (_, v) {
                  /// CLASS DATA DELETE
                  if (v is ClassdataDeleteLoading)
                    loadingDialog(_, _delete, v);
                  else if (v is ClassdatadeleteSuccess) {
                    if (_delete.currentContext != null)
                      Navigator.pop(_delete.currentContext);
                    snackBar(_scaffoldKey, v.message);
                    BlocProvider.of<ClassdataBloc>(context)
                        .add(ClassdataBlocEvent());
                  } else if (v is ClassdataDeleteFailed) {
                    if (_alert.currentContext != null)
                      Navigator.pop(_alert.currentContext);
                  }

                  ///CLASS DATA UPDATE
                  else if (v is ClassdataUpdateLoading)
                    loadingDialog(_, _delete, v);
                  else if (v is ClassdataUpdateSuccess) {
                    if (_delete.currentContext != null)
                      Navigator.pop(_delete.currentContext);
                    snackBar(_scaffoldKey, "berhasil memperbarui data");
                    BlocProvider.of<ClassdataBloc>(context)
                        .add(ClassdataBlocEvent());
                  } else if (v is ClassdataUpdateFailed) {
                    if (_delete.currentContext != null)
                      Navigator.pop(_delete.currentContext);
                    snackBar(_scaffoldKey, "data tidak diperbarui");
                    BlocProvider.of<ClassdataBloc>(context)
                        .add(ClassdataBlocEvent());
                  } else if (v is ClassdataUpdateQueryError) {
                    if (_delete.currentContext != null)
                      Navigator.pop(_delete.currentContext);
                    snackBar(_scaffoldKey, "Kueri bermasalah");
                  } else if (v is ClassdataUpdateServerError) {
                    if (_delete.currentContext != null)
                      Navigator.pop(_delete.currentContext);
                    snackBar(_scaffoldKey, "Server bermasalah");
                  }

                  /// CLASS DATA ADD
                  else if (v is ClassdataAddLoading)
                    loadingDialog(_, _delete, v);
                  else if (v is ClassdataAddSucces) {
                    if (_delete.currentContext != null)
                      Navigator.pop(_delete.currentContext);
                    snackBar(_scaffoldKey, "berhasil menambah kelas");
                    BlocProvider.of<ClassdataBloc>(context)
                        .add(ClassdataBlocEvent());
                  } else if (v is ClassdataAddFailed) {
                    if (_delete.currentContext != null)
                      Navigator.pop(_delete.currentContext);
                    snackBar(_scaffoldKey, "Gagal menambah kelas");
                  } else if (v is ClassdataAddServerError){
                    if (_delete.currentContext != null)
                      Navigator.pop(_delete.currentContext);
                    snackBar(_scaffoldKey, "Gagal menambah kelas, server bermasalah");
                    BlocProvider.of<ClassdataBloc>(context)
                        .add(ClassdataBlocEvent());
                  }
                },
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
