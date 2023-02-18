// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_bloc.dart';

class AccountState extends Equatable {
  final WUser user;

  List<WPlant> get plants => user.plants;
  bool get plantsIsEmpty => user.plants.isEmpty;

  bool get userNotEmpty => UserPref().getUser() != null;

  const AccountState({
    required this.user,
  });

  @override
  List<Object?> get props => [
        user,
      ];

  AccountState copyWith({
    WUser? user,
  }) {
    return AccountState(
      user: user ?? this.user,
    );
  }
}
