import 'package:video_app/features/videos/data/model/video_model.dart';

class AssetData {
  AssetData({
    required this.data,
  });
  List<Videos> data;
  factory AssetData.fromJson(List<dynamic> json) {
    return AssetData(data: json.map((x) => Videos.fromJson(x)).toList());
  }
}
