import 'package:flutter/material.dart';

import '../../utils/screen_config.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({Key? key, required this.title, this.date, this.list})
      : super(key: key);

  final String title;
  final String? date;
  final List<String>? list;

  @override
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  double get _screenRatio => SizeConfig.screenRatio;

  @override
  Widget build(BuildContext context) => Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'PingFangTC-Semibold',
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: _screenRatio * 18,
            ),
          ),
          SizedBox(
            height: _screenRatio * 4,
          ),
          if (widget.date != null)
            Text(
              widget.date!,
              style: TextStyle(
                fontFamily: 'PingFangTC-Semibold',
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: _screenRatio * 12,
              ),
            )
        ]),
        if (widget.list?.isNotEmpty == true) const Spacer(),
        Container(
          child: Row(
            children: [
              Text(
                widget.list!.first,
                style: TextStyle(
                  fontFamily: 'PingFangTC-Semibold',
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: _screenRatio * 14,
                ),
              ),
              SizedBox(
                width: _screenRatio * 4,
              ),
              SizedBox(
                width: _screenRatio * 16,
                height: _screenRatio * 16,
                child: Image.asset('assets/images/arrow_down.png'),
              ),
            ],
          ),
          padding: EdgeInsets.only(
              right: _screenRatio * 16,
              left: _screenRatio * 16,
              top: _screenRatio * 5,
              bottom: _screenRatio * 5),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(_screenRatio * 20)),
              color: const Color.fromRGBO(37, 135, 160, 1)),
        )
      ]);
}
