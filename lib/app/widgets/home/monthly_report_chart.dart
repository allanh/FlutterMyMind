import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../utils/screen_config.dart';
import 'title_widget.dart';

class MonthlyReportChart extends StatefulWidget {
  const MonthlyReportChart({Key? key}) : super(key: key);

  @override
  _MonthlyReportChartState createState() => _MonthlyReportChartState();
}

class _MonthlyReportChartState extends State<MonthlyReportChart> {
  double get _screenRatio => SizeConfig.screenRatio;

  List<Color> gradientColors = [
    const Color.fromRGBO(10, 207, 254, 1),
    const Color.fromRGBO(10, 207, 254, 0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: screenWidth * 0.9146,
      width: _screenRatio * 343.0,
      height: _screenRatio * 316.0,
      //height: screenWidth * 0.8426,
      margin: EdgeInsets.symmetric(horizontal: _screenRatio * 16),
      padding: EdgeInsets.only(
          right: _screenRatio * 16,
          left: _screenRatio * 18,
          top: _screenRatio * 24,
          bottom: _screenRatio * 12),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // 標題
        const TitleWidget(
          title: '近30日數據',
          date: '2021-08-07 ~ 2021-09-25',
          list: ['銷售數據'],
        ),
        SizedBox(
          height: _screenRatio * 8,
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
            height: _screenRatio * 140,
            child: LineChart(
              mainData(),
            ))
      ]),
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/images/chart_bg.png"),
              fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: _screenRatio * 16,
              offset: Offset(0, _screenRatio * 8), // Shadow position
            )
          ]),
    );
  }

  Widget saleTypeWidgets(String title, String value, bool clicked) {
    return Container(
        width: _screenRatio * 151,
        //height: 76,
        child: AspectRatio(
            aspectRatio: 151 / 76,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: _screenRatio * 4,
                      height: _screenRatio * 16,
                      margin: EdgeInsets.only(top: _screenRatio * 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(_screenRatio * 2)),
                          color: const Color.fromRGBO(255, 192, 43, 1)),
                    ),
                    SizedBox(
                      width: _screenRatio * 8,
                    ),
                    SizedBox(
                      height: _screenRatio * 16,
                      child: Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'PingFangTC-Regular',
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: _screenRatio * 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _screenRatio * 33,
                  child: Row(children: [
                    Text(
                      value,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PingFangTC-Semibold',
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: _screenRatio * 24,
                      ),
                    ),
                    if (!clicked)
                      SizedBox(
                        width: _screenRatio * 4,
                      ),
                    if (!clicked)
                      Text(
                        '元',
                        style: TextStyle(
                          fontFamily: 'PingFangTC-Semibold',
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontSize: _screenRatio * 14,
                        ),
                      )
                  ]),
                ),
              ],
            )),
        padding: EdgeInsets.only(
            right: _screenRatio * 16,
            left: _screenRatio * 16,
            top: _screenRatio * 5,
            bottom: _screenRatio * 5),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(clicked
                  ? 'assets/images/dashboard_item.png'
                  : 'assets/images/dashboard_item_disabled.png')),
        ));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: const Color.fromRGBO(255, 255, 255, 0.65),
      fontSize: _screenRatio * 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('10-25', style: style);
        break;
      case 7:
        text = Text('11-01', style: style);
        break;
      case 14:
        text = Text('11-08', style: style);
        break;
      case 21:
        text = Text('11-15', style: style);
        break;
      case 28:
        text = Text('11-30', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return Padding(
        child: text, padding: EdgeInsets.only(top: _screenRatio * 8.0));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: _screenRatio * 1,
        verticalInterval: _screenRatio * 7,
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
            strokeWidth: _screenRatio * 2,
            dashArray: [5, 5],
            label: VerticalLineLabel(
              show: true,
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(
                  left: _screenRatio * 10, top: _screenRatio * 5),
              style: TextStyle(color: Colors.black, fontSize: _screenRatio * 9),
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
            reservedSize: _screenRatio * 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            reservedSize: _screenRatio * 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(
                width: _screenRatio * 1.0, color: const Color(0x800acffe)),
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
          barWidth: _screenRatio * 5,
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
