import 'package:dio/dio.dart';
import 'package:video_app/features/videos/data/model/assets_data.dart';

class ClientCall {
  Dio _dio = Dio();

  /// Method for configuring Dio, the authorization is done from
  /// the API server
  initializeDio() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://my-json-server.typicode.com",
      connectTimeout: 8000,
      receiveTimeout: 5000,
    );
    _dio = Dio(options);
  }

  Future<AssetData> getAssetList() async {
    try {
      Response response = await _dio.get(
        "/mopilo/video_files/videos",
      );
      AssetData assetData = AssetData.fromJson(response.data);
      return assetData;
    } on DioError {
      rethrow;
    }
  }
}
