part of 'classdata_bloc.dart';

abstract class ClassdataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClassdataBlocEvent extends ClassdataEvent {}

class ClassdataReset extends ClassdataEvent {}

/*








 */

abstract class ClassdataDeleteEvent extends ClassdataEvent {
  @override
  List<Object> get props => [];
}

class ClassdataDeleteBlocEvent extends ClassdataEvent {
  final String id;

  ClassdataDeleteBlocEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ClassdataDeleteReset extends ClassdataEvent {}




/// CLASS DATA UPDATE
class ClassdataUpdateBlocEvent extends ClassdataEvent {
  final String _id, _classLevel, _majors, _classCode;

  ClassdataUpdateBlocEvent(this._id, this._classLevel, this._majors, this._classCode);

  @override
  List<Object> get props => [_id, _classLevel, _majors, _classCode];
}