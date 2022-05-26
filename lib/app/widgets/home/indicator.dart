import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final List<Color> colors;
  final String name;
  final double value;
  final bool isSquare;

  const Indicator({
    Key? key,
    required this.colors,
    required this.name,
    required this.value,
    required this.isSquare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Container(
            width: 4,
            height: 24,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            name,
            style: const TextStyle(
                fontFamily: 'PingFangTC-Semibold',
                fontSize: 16,
                color: Colors.white),
          )
        ],
      ),
      Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            '${value.toString()}%',
            style: TextStyle(
                fontFamily: 'PingFangTC-Regular',
                fontSize: 14,
                color: Colors.white.withOpacity(0.65)),
          ))
    ]);
  }
}
