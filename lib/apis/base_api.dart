import 'package:checkpoint/apis/interceptors/request_log_interceptor.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

abstract class BaseApi {
  Dio dio;

  BaseApi() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: 'https://www.ahgora.com.br/',
      headers: {'content-type': 'application/json'},
    );

    dio = Dio(baseOptions);

    dio.interceptors.add(CookieManager(CookieJar()));
    dio.interceptors.add(RequestLogInterceptor());
  }
}
