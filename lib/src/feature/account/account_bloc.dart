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
      final newUser = WUser(id: '1233', plants: []);
      updateUser(newUser);
    }
  }

  void updateUser(WUser user) {
    emit(state.copyWith(user: user));
    UserPref().saveUser(user);
  }

  void updatePlant(String idPlant, double? humidity) {
    int index = state.user.plants.indexWhere((e) => e.id == idPlant);

    List<WPlant> updatedList = List.from(state.user.plants);
    updatedList[index] = updatedList[index].copyWith(humidity: humidity);

    state.user.plants.replaceRange(index, index + 1, updatedList);

    updateUser(state.user.copyWith(plants: state.user.plants));
  }

  remove() {}

  edit() {}
}
