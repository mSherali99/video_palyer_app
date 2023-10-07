import 'package:dio/dio.dart';
import 'package:video_palyer_app/data/model/base_response.dart';
import 'package:video_palyer_app/data/model/video_data.dart';

mixin SecondApi{
  Future<BaseResponse<List<VideoData>>> getSecondVideoList();
}