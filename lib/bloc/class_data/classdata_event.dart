part of 'classdata_bloc.dart';

abstract class ClassdataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClassdataBlocEvent extends ClassdataEvent {}

class ClassdataReset extends ClassdataEvent {}


/// CLASS DATA DELETE
class ClassdataDeleteBlocEvent extends ClassdataEvent {
  final String id;

  ClassdataDeleteBlocEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// CLASS DATA UPDATE
class ClassdataUpdateBlocEvent extends ClassdataEvent {
  final String _id, _classLevel, _majors, _classCode;

  ClassdataUpdateBlocEvent(this._id, this._classLevel, this._majors, this._classCode);

  @override
  List<Object> get props => [_id, _classLevel, _majors, _classCode];
}

// CLASS DATA ADD
class ClassdataAddBlocEvent extends ClassdataEvent {
  final String _classLevel, _majors, _classCode;

  ClassdataAddBlocEvent(this._classLevel, this._majors, this._classCode);

}

