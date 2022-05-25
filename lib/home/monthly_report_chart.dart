import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_mind/home/title_widget.dart';

class MonthlyReportChart extends StatefulWidget {
  const MonthlyReportChart({Key? key}) : super(key: key);

  @override
  _MonthlyReportChartState createState() => _MonthlyReportChartState();
}

class _MonthlyReportChartState extends State<MonthlyReportChart> {
  List<Color> gradientColors = [
    const Color.fromRGBO(10, 207, 254, 1),
    const Color.fromRGBO(10, 207, 254, 0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.0,
      height: 340.0,
      margin: const EdgeInsets.only(right: 16, left: 16),
      padding: const EdgeInsets.only(right: 16, left: 18, top: 24, bottom: 12),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // 標題
        const TitleWidget(
          title: '近30日數據',
          date: '2021-08-07 ~ 2021-09-25',
          list: ['銷售數據'],
        ),
        const SizedBox(
          height: 8,
        ),
        // 數據類型
        Row(children: [
          saleTypeWidgets('數量', '10,000', true),
          const Spacer(),
          saleTypeWidgets('總額', '98,765', false),
        ]),
        const Spacer(),
        // 折線圖
        SizedBox(
            height: 140,
            child: LineChart(
              mainData(),
            ))
      ]),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/chart_bg.png"),
              fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: 16,
              offset: Offset(0, 8), // Shadow position
            )
          ]),
    );
  }

  Widget saleTypeWidgets(String title, String value, bool clicked) {
    return Container(
        width: 151,
        height: 76,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 16,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      color: Color.fromRGBO(255, 192, 43, 1)),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 16,
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'PingFangTC-Regular',
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 33,
              child: Row(children: [
                Text(
                  value,
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: 'PingFangTC-Semibold',
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 24,
                  ),
                ),
                if (!clicked)
                  const SizedBox(
                    width: 4,
                  ),
                if (!clicked)
                  const Text(
                    '元',
                    style: TextStyle(
                      fontFamily: 'PingFangTC-Semibold',
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 14,
                    ),
                  )
              ]),
            ),
          ],
        ),
        padding: const EdgeInsets.only(right: 16, left: 16, top: 5, bottom: 5),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(clicked
                  ? 'assets/images/dashboard_item.png'
                  : 'assets/images/dashboard_item_disabled.png')),
        ));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.65),
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('10-25', style: style);
        break;
      case 7:
        text = const Text('11-01', style: style);
        break;
      case 14:
        text = const Text('11-08', style: style);
        break;
      case 21:
        text = const Text('11-15', style: style);
        break;
      case 28:
        text = const Text('11-30', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 7,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0,
          );
        },
        getDrawingVerticalLine: (value) {
          return VerticalLine(
            x: 5.7,
            color: const Color.fromRGBO(255, 255, 255, 0.1),
            strokeWidth: 2,
            dashArray: [5, 5],
            label: VerticalLineLabel(
              show: true,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(left: 10, top: 5),
              style: const TextStyle(color: Colors.black, fontSize: 9),
              labelResolver: (line) => 'V: ${line.x}',
            ),
          );
          /*
          return FlLine(
            color: const Color(0x800acffe),
            strokeWidth: 2,
          );
          */
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(width: 1.0, color: Color(0x800acffe)),
          )),
      minX: 0,
      maxX: 30,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(4.6, 2),
            FlSpot(8.9, 3),
            FlSpot(12.8, 2.1),
            FlSpot(18, 4),
            FlSpot(23.5, 3.4),
            FlSpot(27, 3.6),
            FlSpot(30, 3.9),
          ],
          isCurved: true,
          color: const Color.fromRGBO(10, 207, 254, 1),
          /*
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          */
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
              begin: Alignment.topCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
