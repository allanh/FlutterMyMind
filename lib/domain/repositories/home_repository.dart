import '../entities/gross_profit.dart';

abstract class HomeRepository {
  Future<List<GrossProfit>> getGrossProfits(GrossProfitType type);
}
