import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../data/repositories/data_home_repository.dart';

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
        if (controller.storeGrossProfits != null) {
          final storeGrossProfits = controller.storeGrossProfits!;

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
                      children: const [
                        SizedBox(height: 24),
                        MonthlyReportChart(),
                        SizedBox(height: 16),
                        GrossProfitPieChart(),
                        SizedBox(height: 24),
                      ]),
                )),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
