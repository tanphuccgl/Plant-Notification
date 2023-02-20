import 'package:flutter/material.dart';

class MoistureIndicator extends StatefulWidget {
  final double moistureLevel;

  MoistureIndicator({Key? key, required this.moistureLevel}) : super(key: key);

  @override
  _MoistureIndicatorState createState() => _MoistureIndicatorState();
}

class _MoistureIndicatorState extends State<MoistureIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;
  late Animation<double> _heightTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _colorTween = ColorTween(begin: Colors.redAccent, end: Colors.lightGreenAccent)
        .animate(_controller);
    _heightTween = Tween<double>(begin: 0.0, end: widget.moistureLevel)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 3,
            ),
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: _heightTween.value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: _colorTween.value,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          '${widget.moistureLevel.toStringAsFixed(0)}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
