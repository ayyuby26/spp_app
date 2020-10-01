import 'package:flutter/material.dart';
import 'package:spp_app/ui/student_page/student_page_dialog.dart';
// import 'package:spp_app/utils/show_dialog.dart';

class StudentDataRow extends StatelessWidget {
  final List<DataRow> listDataRow;
  const StudentDataRow({Key key, this.listDataRow}) : super(key: key);

  List<DataRow> classdataProcess(
    List v,
    GlobalKey<ScaffoldState> _scaffoldKey,
    BuildContext _,
  ) {
    List<DataRow> listDataRow = [];
    listDataRow.clear();

    for (int i = 0; i < v.length; i++)
      listDataRow.add(
        DataRow(cells: <DataCell>[
          DataCell(Text(v[i].studentId)),
          DataCell(Text(v[i].classId)),
          DataCell(Text(v[i].studentName)),
          DataCell(Text(v[i].sex)),
          DataCell(Text(v[i].dateOfBirth)),
          DataCell(Text(v[i].address)),
          DataCell(Text(v[i].religion)),
          DataCell(Text(v[i].schoolYear)),
          DataCell(Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  StudentPageDialog.addEditDialog(
                    _,
                    StudentDialogType.edit,
                    studentId: v[i].studentId,
                    classId: v[i].classId,
                    studentName: v[i].studentName,
                    sex: v[i].sex,
                    dateOfBirth: v[i].dateOfBirth,
                    address: v[i].address,
                    religion: v[i].religion,
                    schoolYear: v[i].schoolYear,
                  );
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
                onTap: () {
                  // deleteDialog(
                  //     _scaffoldKey,
                  //     _,
                  //     "Apakah anda yakin ingin menghapus kelas " +
                  //         v[i].classLevel +
                  //         " " +
                  //         v[i].majors +
                  //         " " +
                  //         v[i].classCode +
                  //         " ?",
                  //     v[i].classId);
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

  @override
  Widget build(BuildContext context) {
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
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: MediaQuery.of(context).size.height - 170,
                margin: EdgeInsets.only(top: 20, bottom: 20),
                // padding: EdgeInsets.only(bottom: 10),
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        sortColumnIndex: 0,
                        sortAscending: true,
                        columnSpacing: 20,
                        horizontalMargin: 20,
                        columns: [
                          DataColumn(
                            label: Text("ID Siswa"),
                          ),
                          DataColumn(label: Text("ID kelas")),
                          DataColumn(label: Text("Nama Siswa")),
                          DataColumn(label: Text("Jenis Kelamin")),
                          DataColumn(label: Text("Tanggal Lahir")),
                          DataColumn(label: Text("Alamat")),
                          DataColumn(label: Text("Agama")),
                          DataColumn(label: Text("Tahun Ajar")),
                          DataColumn(label: Text("")),
                        ],
                        rows: listDataRow),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                ),
              ),
            ),
          );
  }
}
