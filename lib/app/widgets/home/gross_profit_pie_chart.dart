import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:my_mind/app/utils/colors.dart';
import '../../../domain/entities/gross_profit.dart';
import '../../utils/screen_config.dart';
import 'title_widget.dart';

import 'indicator.dart';

class GrossProfitPieChart extends StatefulWidget {
  const GrossProfitPieChart({Key? key, this.grossProfits}) : super(key: key);
  final List<GrossProfit>? grossProfits;
  @override
  _GrossProfitPieChartState createState() => _GrossProfitPieChartState();
}

class _GrossProfitPieChartState extends State<GrossProfitPieChart> {
  int touchedIndex = -1;
  List<GrossProfit> get _grossProfits =>
      widget.grossProfits?.take(sectionSize).toList() ?? [];

  final sectionSize = 6;
  double get _screenRatio => SizeConfig.screenRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _screenRatio * 335.0,
        height: _screenRatio * 498.0,
        margin: EdgeInsets.symmetric(horizontal: _screenRatio * 16),
        padding: EdgeInsets.only(
            right: _screenRatio * 16,
            left: _screenRatio * 16,
            top: _screenRatio * 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          // 標題
          const TitleWidget(
            title: '近7日銷售金額佔比',
            date: '2021-08-07 ~ 2021-09-25',
            list: ['通路商店'],
          ),
          SizedBox(
            height: _screenRatio * 46,
          ),
          // 圓餅圖
          Container(
            width: _screenRatio * 200,
            height: _screenRatio * 200,
            child: Stack(children: [
              _grossProfitWidget(_grossProfits),
              Center(
                child: Text('通路商店',
                    style: TextStyle(
                      fontFamily: 'PingFangTC-Semibold',
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: _screenRatio * 18,
                    )),
              )
            ]),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(_screenRatio * 16)),
              image: const DecorationImage(
                  image: AssetImage("assets/images/pie_chart_bg.png"),
                  fit: BoxFit.cover),
            ),
          ),

          SizedBox(height: _screenRatio * 24),
          SizedBox(
            height: _screenRatio * 150,
            child: Padding(
                padding: EdgeInsets.only(left: _screenRatio * 8),
                child: _storeGridView(_grossProfits)),
          ),
        ]),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_screenRatio * 16)),
            image: const DecorationImage(
                image: AssetImage("assets/images/pie_chart_card_bg.png"),
                fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: _screenRatio * 16,
                offset: Offset(0, _screenRatio * 8), // Shadow position
              )
            ]));
  }

  Widget _storeGridView(List<GrossProfit> list) => (list.isNotEmpty)
      ? GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: _screenRatio * 10,
            mainAxisExtent: _screenRatio * 50,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sectionSize,
          itemBuilder: (BuildContext context, int index) {
            return Indicator(
              colors: MyMindColors.pieChartColors[index],
              name: list[index].name,
              value: list[index].value,
              isSquare: true,
            );
          },
        )
      : const Text('empty');

  Widget _grossProfitWidget(List<GrossProfit> list) => (list.isNotEmpty)
      ? PieChart(
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
              centerSpaceRadius: _screenRatio * 65,
              sections: _pieSections(list)),
        )
      : const Text('empty');

  List<PieChartSectionData> _pieSections(List<GrossProfit> list) {
    List<PieChartSectionData> datas = [];
    final radius = _screenRatio * 20.0;

    list.take(6).forEachIndexed((index, element) {
      //final isTouched = index == touchedIndex;
      //final fontSize = isTouched ? 25.0 : 16.0;
      //final radius = isTouched ? 30.0 : 20.0;
      datas.add(PieChartSectionData(
        color: MyMindColors.pieChartColors[index].first,
        value: element.value,
        radius: radius,
        showTitle: false,
      ));
    });
    return datas;
  }
}
