import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp/bloc/class_data/classdata_bloc.dart';
import 'package:spp/ui_data/class_data_process.dart';
import 'package:spp/utils/show_dialog.dart';
import 'package:spp/utils/snack_bar.dart';

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
          onPressed: () {}),
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
                    listener: (_, c) {
                      if (c is ClassdataDeleteLoading)
                        loadingDialog(_, _delete, c);
                      else if (c is ClassdatadeleteSuccess) {
                        if (_delete.currentContext != null)
                          Navigator.pop(_delete.currentContext);
                        snackBar(_scaffoldKey, c.message);
                        BlocProvider.of<ClassdataBloc>(context)
                            .add(ClassdataBlocEvent());
                      } else if (c is ClassdataDeleteFailed) {
                        if (_alert.currentContext != null)
                          Navigator.pop(_alert.currentContext);
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
