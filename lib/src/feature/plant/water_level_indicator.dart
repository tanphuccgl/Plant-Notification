import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:plant_notification/src/feature/plant/water_level_bloc.dart';

class WaterLevelIndicator extends StatefulWidget {
  final double waterLevel;

  const WaterLevelIndicator({super.key, required this.waterLevel});

  @override
  State<WaterLevelIndicator> createState() => _WaterLevelIndicatorState();
}

class _WaterLevelIndicatorState extends State<WaterLevelIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterLevelBloc, WaterLevelState>(
      buildWhen: (p, c) => p.waterLevel != c.waterLevel,
      builder: (_, state) {
        _animationController.animateTo(state.waterLevel);

        return SizedBox(
          height: 30,
          width: 200,
          child: LiquidLinearProgressIndicator(
            value: _animationController.value,
            backgroundColor: Colors.grey[200],
            valueColor:
                AlwaysStoppedAnimation(Colors.lightBlueAccent.withOpacity(0.8)),
            borderRadius: 10.0,
            direction: Axis.horizontal,
            borderColor: Colors.white,
            borderWidth: 0.5,
            center: Text(
              '${(state.waterLevel.abs() * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
          ),
        );
      },
    );
  }
}
