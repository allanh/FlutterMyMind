import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../domain/entities/gross_profit.dart';

import './home_presenter.dart';

class HomeController extends Controller {
  List<GrossProfit>? _storeGrossProfits;
  List<GrossProfit>? get storeGrossProfits =>
      _storeGrossProfits; // data used by the View
  final HomePresenter homePresenter;
  // Presenter should always be initialized this way
  HomeController(homeRepo)
      : homePresenter = HomePresenter(homeRepo),
        super();

  @override
  void onInitState() {
    // TODO: 只取通路商店
    getGrossProfits(GrossProfitType.store);
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    homePresenter.getGrossProfitsOnNext = (List<GrossProfit>? moduleList) {
      debugPrint(moduleList.toString());
      _storeGrossProfits = moduleList;
      refreshUI(); // Refreshes the UI manually
    };
    homePresenter.getGrossProfitsOnComplete = () {
      debugPrint('Module list retrieved');
    };

    // On error, show a snackbar, remove the module list, and refresh the UI
    homePresenter.getGrossProfitsOnError = (e) {
      debugPrint('Could not get storeGrossProfits');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _storeGrossProfits = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void getGrossProfits(GrossProfitType type) =>
      homePresenter.getGrossProfits(type);

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be reassembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
