import 'package:video_palyer_app/data/model/base_response.dart';
import 'package:video_palyer_app/data/model/base_response.dart';
import 'package:video_palyer_app/data/model/video_data.dart';

mixin NetworkRepository{
  Future<BaseResponse<List<VideoData>>> getFirstList(int startIndex);
  Future<BaseResponse<List<VideoData>>> getSecondList(int startIndex);
}