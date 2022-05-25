import 'package:my_mind/domain/entities/gross_profit.dart';
import 'package:my_mind/domain/usecases/home/get_gross_profit.dart';

import '../../../domain/usecases/home/get_gross_profit.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  late Function getGrossProfitsOnNext;
  late Function getGrossProfitsOnComplete;
  late Function getGrossProfitsOnError;

  final GetGrossProfitsUseCase getGrossProfitsUseCase;
  HomePresenter(homeRepo)
      : getGrossProfitsUseCase = GetGrossProfitsUseCase(homeRepo);

  void getGrossProfits(GrossProfitType type) {
    // execute getUseruserCase
    getGrossProfitsUseCase.execute(_GetGrossProfitsUseCaseObserver(this),
        GetGrossProfitsUseCaseParams(type));
  }

  @override
  void dispose() {
    getGrossProfitsUseCase.dispose();
  }
}

class _GetGrossProfitsUseCaseObserver
    extends Observer<GetGrossProfitsUseCaseResponse> {
  final HomePresenter presenter;
  _GetGrossProfitsUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    // assert(presenter.getUserOnComplete != null);
    presenter.getGrossProfitsOnComplete();
  }

  @override
  void onError(e) {
    // assert(presenter.getUserOnError != null);
    presenter.getGrossProfitsOnError(e);
  }

  @override
  void onNext(response) {
    // assert(presenter.getUserOnNext != null);
    presenter.getGrossProfitsOnNext(response?.grossProfits);
  }
}
