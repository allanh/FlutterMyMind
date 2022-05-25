import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'title_widget.dart';

import 'indicator.dart';

class GrossProfitPieChart extends StatefulWidget {
  const GrossProfitPieChart({Key? key}) : super(key: key);

  @override
  _GrossProfitPieChartState createState() => _GrossProfitPieChartState();
}

class _GrossProfitPieChartState extends State<GrossProfitPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 335.0,
        height: 498.0,
        margin: const EdgeInsets.only(right: 16, left: 16),
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          // 標題
          const TitleWidget(
            title: '近7日銷售金額佔比',
            date: '2021-08-07 ~ 2021-09-25',
            list: ['通路商店'],
          ),
          const SizedBox(
            height: 46,
          ),
          // 折線圖
          Container(
            width: 200,
            height: 200,
            child: PieChart(
              PieChartData(
                  pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 65,
                  sections: showingSections()),
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                  image: AssetImage("assets/images/pie_chart_bg.png"),
                  fit: BoxFit.cover),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Indicator(
                color: Color(0xffffa01e),
                text: '漢高',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xfff8b250),
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xff845bef),
                text: 'Third',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xff13d38e),
                text: 'Fourth',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ]),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            image: DecorationImage(
                image: AssetImage("assets/images/pie_chart_card_bg.png"),
                fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 16,
                offset: Offset(0, 8), // Shadow position
              )
            ]));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 30.0 : 20.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffffa01e),
            value: 30.05,
            title: '30.05%',
            radius: radius,
            showTitle: false,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 8.55,
            title: '8.55%',
            radius: radius,
            showTitle: false,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 2.21,
            title: '2.21%',
            radius: radius,
            showTitle: false,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 18.77,
            title: '18.77%',
            radius: radius,
            showTitle: false,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
