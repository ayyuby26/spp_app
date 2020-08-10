part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AccountBlocEvent extends AccountEvent {
  final String _user, _pass;

  AccountBlocEvent(this._user, this._pass);
  
  @override
  List<Object> get props => [_user, _pass];
}

class AccountReset extends AccountEvent {}