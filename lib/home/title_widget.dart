import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) => Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'PingFangTC-Semibold',
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          if (widget.date != null)
            Text(
              widget.date!,
              style: const TextStyle(
                fontFamily: 'PingFangTC-Semibold',
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 12,
              ),
            )
        ]),
        if (widget.list?.isNotEmpty == true) const Spacer(),
        Container(
          child: Row(
            children: [
              Text(
                widget.list!.first,
                style: const TextStyle(
                  fontFamily: 'PingFangTC-Semibold',
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 16,
                height: 16,
                child: Image.asset('assets/images/arrow_down.png'),
              ),
            ],
          ),
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 5, bottom: 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromRGBO(37, 135, 160, 1)),
        )
      ]);
}
