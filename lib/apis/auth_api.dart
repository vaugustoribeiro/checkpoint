import 'package:checkpoint/apis/base_api.dart';
import 'package:dio/dio.dart';

class AuthApi extends BaseApi {
  Future login(
    String company,
    String origin,
    String registration,
    String password,
  ) async {
    var response = await dio.post(
      'externo/login',
      data: FormData.fromMap({
        'empresa': company,
        'origin': origin,
        'matricula': registration,
        'senha': password,
      }),
    );

    if (response.data['jwt'] == null) {
      throw Exception(response.data['text']);
    }
  }

  Future logout() async {
    await dio.get('externo/logout');
  }
}
