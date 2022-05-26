import 'package:flutter/material.dart';

import '../../utils/screen_config.dart';

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
    double _screenRatio = SizeConfig.screenRatio;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Container(
            width: _screenRatio * 4,
            height: _screenRatio * 24,
            margin: EdgeInsets.only(top: _screenRatio * 5),
            decoration: BoxDecoration(
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                borderRadius:
                    BorderRadius.all(Radius.circular(_screenRatio * 2)),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ),
          SizedBox(
            width: _screenRatio * 8,
          ),
          Text(
            name,
            style: TextStyle(
                fontFamily: 'PingFangTC-Semibold',
                fontSize: _screenRatio * 16,
                color: Colors.white),
          )
        ],
      ),
      Padding(
          padding: EdgeInsets.only(left: _screenRatio * 12),
          child: Text(
            '${value.toString()}%',
            style: TextStyle(
                fontFamily: 'PingFangTC-Regular',
                fontSize: _screenRatio * 14,
                color: Colors.white.withOpacity(0.65)),
          ))
    ]);
  }
}
