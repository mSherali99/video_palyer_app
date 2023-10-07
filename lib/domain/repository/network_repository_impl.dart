import 'package:flutter/foundation.dart';
import 'package:video_palyer_app/data/model/base_response.dart';
import 'package:video_palyer_app/data/model/video_data.dart';
import 'package:video_palyer_app/data/source/remote/api/first_api.dart';
import 'package:video_palyer_app/data/source/remote/api/second_api.dart';
import 'package:video_palyer_app/domain/repository/network_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  FirstApi _firstApi;
  SecondApi _secondApi;
  List<VideoData> firstList = [];




  NetworkRepositoryImpl(this._firstApi, this._secondApi)  {
    var firstList = _firstApi.getFirstVideoList();
    var secondList = _secondApi.getSecondVideoList();
  }


  @override
  Future<BaseResponse<List<VideoData>>> getFirstList(int startIndex) {

    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<List<VideoData>>> getSecondList(int startIndex) {
    // TODO: implement getSecondList
    throw UnimplementedError();
  }


}
