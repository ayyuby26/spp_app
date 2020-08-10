import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spp/models/class_data.dart';

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
    } else if (event is ClassdataDeleteBlocEvent) {
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
    } else if (event is ClassdataUpdateBlocEvent) {
      yield ClassdataUpdateLoading();
      try {
        String message = await ClassData.classDataUpdate(
            event._id, event._classLevel, event._majors, event._classCode);
        if (message == "success")
          yield ClassdataUpdateSuccess(message);
        else if (message == "failed")
          yield ClassdataUpdateFailed();
        else
          yield ClassdataUpdateQueryError();
      } catch (e) {
        yield ClassdataUpdateServerError();
      }
    }
  }
}