import 'dart:async';

import '../../entities/gross_profit.dart';
import '../../repositories/home_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetGrossProfitsUseCase extends UseCase<GetGrossProfitsUseCaseResponse,
    GetGrossProfitsUseCaseParams> {
  final HomeRepository homeRepository;
  GetGrossProfitsUseCase(this.homeRepository);

  @override
  Future<Stream<GetGrossProfitsUseCaseResponse?>> buildUseCaseStream(
      GetGrossProfitsUseCaseParams? params) async {
    final controller = StreamController<GetGrossProfitsUseCaseResponse>();

    if (params?.type != null) {
      try {
        // get GrossProfits
        final grossProfits = await homeRepository.getGrossProfits(params!.type);
        // Adding it triggers the .onNext() in the `Observer`
        // It is usually better to wrap the reponse inside a respose object.
        controller.add(GetGrossProfitsUseCaseResponse(grossProfits));
        logger.finest('GetGrossProfitsUseCase successful.');
        controller.close();
      } catch (e) {
        logger.severe('GetGrossProfitsUseCase unsuccessful.');
        // Trigger .onError
        controller.addError(e);
      }
    } else {
      logger.severe(
          'GetGrossProfitsUseCase unsuccessful. GrossProfits id is null');
      // Trigger .onError
      controller.addError(Exception('GrossProfits id is null'));
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class GetGrossProfitsUseCaseParams {
  final GrossProfitType type;
  GetGrossProfitsUseCaseParams(this.type);
}

class GetGrossProfitsUseCaseResponse {
  final List<GrossProfit> grossProfits;
  GetGrossProfitsUseCaseResponse(this.grossProfits);
}
