import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_notification/src/models/plant_model.dart';
import 'package:plant_notification/src/models/user_model.dart';

import 'user_local.dart';

part 'account_state.dart';

class AccountBloc extends Cubit<AccountState> {
  AccountBloc() : super(AccountState(user: WUser.empty())) {
    getDataAccount();
  }

  void getDataAccount() {
    if (state.userNotEmpty) {
      emit(state.copyWith(user: UserPref().getUser()));
    } else {
      final newUser = WUser(id: '123', plants: []);
      updateUser(newUser);
    }
  }

  void updateUser(WUser user) {
    emit(state.copyWith(user: user));
    UserPref().saveUser(user);
  }

  remove() {}

  edit() {}
}
