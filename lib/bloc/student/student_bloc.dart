import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spp_app/models/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial());

  @override
  Stream<StudentState> mapEventToState(
    StudentEvent event,
  ) async* {
    // SELECT
    if (event is StudentBlocEvent) {
      yield StudentLoading();
      try {
        List<Student> _list = await Student.getStudent();
        if (_list != null) yield StudentLoaded(_list);
      } catch (_) {
        yield StudentFailed();
      }
    }

    // ADD
    // if (event is StudentBloEvent) {
    //   yield StudentLoading();
    //   try {
    //     List<Student> list = await Student.getStudent();
    //     if (list != null) yield StudentLoaded(list);
    //   } catch (e) {
    //     yield StudentEmpty();
    //   }
    // }
  }
}
