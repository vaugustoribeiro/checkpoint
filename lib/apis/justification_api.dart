import 'package:checkpoint/apis/base_api.dart';
import 'package:intl/intl.dart';

class JustificationApi extends BaseApi {
  final String uri = 'api-espelho/justificativas';

  Future get(
    DateTime validity,
  ) async {
    var from = DateTime(validity.year, validity.month, 1);
    var to = DateTime(validity.year, validity.month + 1, 0);

    var formatter = DateFormat('yyyy-MM-dd');

    var response = await dio.get(uri, queryParameters: {
      'inicio': formatter.format(from),
      'fim': formatter.format(to),
    });

    return response.data;
  }

  Future post(DateTime date, String message) async {
    var refFormatter = DateFormat('yyyy-MM-dd');
    var hourFormatter = DateFormat('HH:mm');

    var ref = refFormatter.format(date);
    var hour = hourFormatter.format(date);

    await dio.post(uri, data: {
      'referencia': ref,
      'tipo': 'addPunch',
      'justificativa': 'outros',
      'mensagem': message,
      'addPunch': {
        'hora': hour,
      },
    });
  }
}
