import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spp_app/bloc/class_data/classdata_bloc.dart';
import 'package:spp_app/ui/class_page/class_page_dialog.dart';
import 'package:spp_app/utils/show_dialog.dart';

List<DataRow> classdataProcess(
    List v, GlobalKey<ScaffoldState> _scaffoldKey, _) {
  List<DataRow> listDataRow = [];
  listDataRow.clear();
  for (int i = 0; i < v.length; i++)
    listDataRow.add(
      DataRow(cells: <DataCell>[
        DataCell(Text(v[i].classLevel)),
        DataCell(Text(v[i].majors)),
        DataCell(Text(v[i].classCode)),
        DataCell(Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                ClassPageDialog.addEditDialog(_, v[i].classId, v[i].classLevel, v[i].majors,
                    v[i].classCode);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(width: 0),
            InkWell(
              onTap: () async {
                await deleteDialog(
                  _,
                  "Apakah anda yakin ingin menghapus kelas " +
                      v[i].classLevel +
                      " " +
                      v[i].majors +
                      " " +
                      v[i].classCode +
                      " ?",
                )
                    ? ckl(_, v[i].classId)
                    // ignore: unnecessary_statements
                    : null;
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ],
        )),
      ]),
    );
  return listDataRow;
}

classdataTable(List v, List<DataRow> listDataRow, BuildContext context) {
  return listDataRow.length == 0
      ? Center(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Text(
              "tidak ada data",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        )
      : Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: MediaQuery.of(context).size.height - 170,
              margin: EdgeInsets.only(top: 20, bottom: 20),
              // padding: EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
                child: DataTable(
                    sortColumnIndex: 0,
                    sortAscending: true,
                    columnSpacing: 20,
                    horizontalMargin: 20,
                    columns: [
                      DataColumn(
                          label: Text("kelas"),
                          onSort: (_, __) {
                            print(_.toString() + __.toString());
                            // ignore: close_sinks
                            final accountBloc =
                                BlocProvider.of<ClassdataBloc>(context);
                            accountBloc.add(ClassSortSmall(__, v));
                          }),
                      DataColumn(label: Text("jurusan")),
                      DataColumn(label: Text("kode")),
                      DataColumn(label: Text("")),
                    ],
                    rows: listDataRow),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
            ),
          ),
        );
}

ckl(BuildContext context, String id) {
  context.bloc<ClassdataBloc>().add(ClassdataDeleteBlocEvent(id));
}
