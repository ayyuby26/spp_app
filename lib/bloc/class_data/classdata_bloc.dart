import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spp_app/models/class_data.dart';

part 'classdata_event.dart';
part 'classdata_state.dart';

class ClassdataBloc extends Bloc<ClassdataEvent, ClassdataState> {
  ClassdataBloc() : super(ClassdataInitial());

  @override
  Stream<ClassdataState> mapEventToState(ClassdataEvent event) async* {
    if (event is ClassdataBlocEvent) {
      yield ClassdataLoading();
      try {
        List<ClassData> list = await ClassData.getClassData();
        if (list != null) yield ClassdataLoaded(list);
      } catch (e) {
        yield ClassdataFailed();
      }
    }

    /// CLASS DATA DELETE
    else if (event is ClassdataDeleteBlocEvent) {
      yield ClassdataDeleteLoading();
      try {
        String message = await ClassData.classDataDelete(event.id);
        if (message != null)
          yield ClassdatadeleteSuccess(message);
        else
          yield ClassdataDeleteFailed();
      } catch (e) {
        yield ClassdataDeleteFailed();
      }
    }

    /// CLASS DATA UPDATE
    else if (event is ClassdataUpdateBlocEvent) {
      yield ClassdataUpdateLoading();
      try {
        String message = await ClassData.classDataUpdate(
            event._id, event._classLevel, event._majors, event._classCode);
        if (message == "success")
          yield ClassdataUpdateSuccess();
        else if (message == "failed")
          yield ClassdataUpdateFailed();
        else
          yield ClassdataUpdateQueryError();
      } catch (e) {
        yield ClassdataUpdateServerError();
      }
    }

    /// CLASS DATA ADD
    else if (event is ClassdataAddBlocEvent) {
      yield ClassdataAddLoading();
      try {
        String _message = await ClassData.classDataAdd(
            event._classLevel, event._majors, event._classCode);
        if (_message == "success")
          yield ClassdataAddSucces(_message);
        else if (_message == "failed")
          yield ClassdataAddFailed();
        else
          yield ClassdataAddServerError();
      } catch (e) {
        yield ClassdataAddServerError();
      }
    }

    //SORT
    else if (event is ClassSortSmall) {
      yield ClassdataSortLoading();
      try {
        if (event.status)
          event.v.sort((a, b) =>
              int.parse(a.classLevel).compareTo(int.parse(b.classLevel)));
        else
          event.v.sort((a, b) =>
              int.parse(b.classLevel).compareTo(int.parse(a.classLevel)));
        yield ClassdataLoaded(event.v);
      } catch (e) {
        yield ClassdataAddServerError();
      }
    }
  }
}
