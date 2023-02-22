// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "store_bloc.dart";

class StoreState extends Equatable {
  final int currentPageIndex;
  bool get userNotEmpty => GetIt.I<AccountBloc>().state.user.id != '';

  bool isSold(String id) =>
      GetIt.I<AccountBloc>().state.plants.where((e) => e.id == id).isNotEmpty;

  const StoreState({this.currentPageIndex = 0});

  @override
  List<Object?> get props => [
        currentPageIndex,
      ];

  StoreState copyWith({
    int? currentPageIndex,
  }) {
    return StoreState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}
