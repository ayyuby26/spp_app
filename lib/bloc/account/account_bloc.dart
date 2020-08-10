import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spp/models/account.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is AccountBlocEvent) {
      yield AccountIsLoading();
      try {
        Account account = await Account.getAccount(event._user, event._pass);
        if (account.user != null)
          yield AccountIsValid(account);
        else
          yield AccountIsWrong();
      } catch (e) {
        yield AccountNotLogin();
      }
    } else if (event is AccountReset) {
      yield AccountInitial();
    }
  }
}
