// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "home_bloc.dart";

class HomeState extends Equatable {
  final int currentPageIndex;

  const HomeState({this.currentPageIndex = 0});

  @override
  List<Object?> get props => [
        currentPageIndex,
      ];

  HomeState copyWith({
    int? currentPageIndex,
  }) {
    return HomeState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}
