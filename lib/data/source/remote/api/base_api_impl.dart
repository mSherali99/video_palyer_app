import 'package:dio/dio.dart';
import 'package:video_palyer_app/data/model/base_response.dart';
import 'package:video_palyer_app/data/model/video_data.dart';
import 'package:video_palyer_app/data/source/remote/api/first_api.dart';
import 'package:video_palyer_app/data/source/remote/api/second_api.dart';

class BaseApiImpl implements FirstApi, SecondApi {
  final Dio _dio;

  BaseApiImpl(this._dio);

  @override
  Future<BaseResponse<List<VideoData>>> getFirstVideoList() async {
    List<VideoData> videos = [];

    BaseResponse<List<VideoData>> result = Success(videos);
    try {
      var response =
          await _dio.get("https://api.npoint.io/58d2839c8d77a8027369");
      int status = response.statusCode ?? 0;
      if (status >= 200 && status <= 300) {
        result = Success(
            (response.data as List).map((e) => VideoData.fromJson(e)).toList());
      } else {
        result = Error(Exception(response.statusMessage));
      }
    } catch (e) {
      result = Error(Exception(e));
    }
    return result;
  }

  @override
  Future<BaseResponse<List<VideoData>>> getSecondVideoList() async {
    List<VideoData> videos = [];

    BaseResponse<List<VideoData>> result = Success(videos);
    try {
      var response =
          await _dio.get("https://api.npoint.io/7a3cc27530497fc9d95a");
      int status = response.statusCode ?? 0;
      if (status >= 200 && status <= 300) {
        result = Success(
            (response.data as List).map((e) => VideoData.fromJson(e)).toList());
      } else {
        result = Error(Exception(response.statusMessage));
      }
    } catch (e) {
      result = Error(Exception(e));
    }
    return result;
  }
}
