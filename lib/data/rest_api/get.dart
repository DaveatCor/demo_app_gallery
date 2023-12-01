import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as _http;

class GetApi {

  GetApi._privateConstructor();

  static final GetApi _getApi = GetApi._privateConstructor();

  static GetApi get getApi => _getApi;

  /// Query 100 images per Page
  Future<_http.Response> getListImages({int page = 0, int limit = 10}) async {
    return _http.get( Uri.parse("${dotenv.get('API_URL')}/list?page=$page&limit=$limit") );
  }

  Future<_http.Response> downloadUrlImg(String urlImage) async {
    return await _http.Client().get(Uri.parse(urlImage));
  }
}