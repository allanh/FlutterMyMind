import '../../domain/entities/gross_profit.dart';
import '../../domain/repositories/home_repository.dart';

class DataHomeRepository extends HomeRepository {
  late List<GrossProfit> storeGrossProfit;
  late List<GrossProfit> supplierGrossProfit;

  // sigleton
  static final DataHomeRepository _instance = DataHomeRepository._internal();
  DataHomeRepository._internal() {
    storeGrossProfit = <GrossProfit>[];
    storeGrossProfit.addAll([
      GrossProfit('蝦皮商城', 30.05),
      GrossProfit('momo購物中心', 8.55),
      GrossProfit('ETMall東森購物', 2.21),
      GrossProfit('Yahoo購物中心', 18.77),
      GrossProfit('Shopline蝦皮商城', 29.21),
      GrossProfit('Rakuten台灣樂天', 11.21),
    ]);
  }
  factory DataHomeRepository() => _instance;

  // TODO: 先回通路的假資料
  @override
  Future<List<GrossProfit>> getGrossProfits(GrossProfitType type) async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data
    return storeGrossProfit;
  }
}
