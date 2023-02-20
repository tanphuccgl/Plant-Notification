part of 'water_level_bloc.dart';

class WaterLevelState extends Equatable {
  final double waterLevel;

  const WaterLevelState({required this.waterLevel});

  @override
  List<Object?> get props => [
        waterLevel,
      ];

      WaterLevelState copyWith({
    double? waterLevel,
  }) {
    return WaterLevelState(
      waterLevel: waterLevel ?? this.waterLevel,
    );
  }
}
