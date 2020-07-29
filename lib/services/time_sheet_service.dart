import 'package:checkpoint/apis/counting_api.dart';
import 'package:checkpoint/apis/justification_api.dart';

class TimeSheetService {
  final CountingApi _countingApi = CountingApi();
  final JustificationApi _justificationApi = JustificationApi();

  Future<Map<String, dynamic>> get(DateTime validity) async {
    var responses = await Future.wait(
      [_countingApi.get(validity), _justificationApi.get(validity)],
    );

    var pendingJustifications = responses[1]['data']
        .where((p) => p['estado'] == 'PENDENTE' && p['tipo'] == 'addPunch')
        .toList();

    pendingJustifications.forEach((pj) {
      responses[0]['days'][pj['referencia']]['batidas'].add({
        'hora': pj['addPunch']['hora'],
        'motivo': pj['mensagem'],
        'pending': true,
      });
    });

    return responses[0];
  }
}
