import 'package:checkpoint/apis/base_api.dart';
import 'package:intl/intl.dart';

class CountingApi extends BaseApi {
  final String uri = 'api-espelho/apuracao';

  Future get(
    DateTime validity,
  ) async {
    var formatter = DateFormat('yyyy-MM');

    var from = formatter.format(DateTime(validity.year, validity.month, 0));
    var to = formatter.format(DateTime(validity.year, validity.month, 1));

    print('from: $from, to: $to');

    var requests = Future.wait([
      dio.get('$uri/$from'),
      dio.get('$uri/$to'),
    ]);

    var responses = await requests;

    var totals = responses[1].data['meses'][to]['totais'] as List;

    var balances = totals.where((p) => p['descricao'] == 'SALDO').toList();

    Map<String, dynamic> balance = {'valor': '0'};

    if (balances.isNotEmpty) {
      balance['valor'] = balances[0]['valor'];
    }

    Map<String, dynamic> data = {
      'user': responses[0].data['funcionario'],
      'bank': balance['valor'],
      'days': {},
    };

    responses.forEach((response) {
      response.data['dias'].forEach((k, v) {
        data['days'][k] = v;
      });
    });

    return data;
  }
}
