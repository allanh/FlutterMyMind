import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:my_mind/domain/entities/gross_profit.dart';
import '../../../data/repositories/data_home_repository.dart';

import '../../utils/screen_config.dart';
import '../../widgets/home/gross_profit_pie_chart.dart';
import '../../widgets/home/monthly_report_chart.dart';
import './home_controller.dart';

class HomePage extends View {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataHomeRepository()));

  @override
  Widget get view {
    return ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        SizeConfig().init(context);

        if (controller.storeGrossProfits != null) {
          List<GrossProfit> storeGrossProfits = controller.storeGrossProfits!;
          double _screenRatio = SizeConfig.screenRatio;

          return Scaffold(
            key: globalKey,
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: const Text('My Mind Demo'),
            ),
            body: Container(
                color: const Color(0xfff5f6f8),
                child: SafeArea(
                  child: ListView(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: _screenRatio * 24),
                        const MonthlyReportChart(),
                        SizedBox(height: _screenRatio * 16),
                        GrossProfitPieChart(
                          grossProfits: storeGrossProfits,
                        ),
                        SizedBox(height: _screenRatio * 24),
                      ]),
                )),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
