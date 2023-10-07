import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_palyer_app/data/model/video_data.dart';
import 'package:video_palyer_app/data/source/remote/api/second_api.dart';
import 'package:video_palyer_app/presentation/screen/play/play_bloc.dart';
import 'package:video_palyer_app/presentation/screen/play/play_screen.dart';

part 'favourite_event.dart';

part 'favourite_state.dart';

class FavouriteBlock extends Bloc<FavouriteEvent, FavouriteState> {
  final SecondApi _api;

  FavouriteBlock(this._api) : super(const FavouriteState()) {
    on<FavouriteEvent>((event, emit) async {
      switch (event) {
        case Loading():
          await _onLoadData(event, emit);
          break;
        case OpenDetailsScreen2():
          _openPlayScreen(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoadData(Loading event, Emitter<FavouriteState> emit) async {
    emit(state.copyWith(status: EnumStatus.loading));
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final list = <VideoData>[];
        list.addAll(state.videosList);
        (await _api.getSecondVideoList()).onSuccess((list) {
          List<VideoData> searchList = list
              .where((element) => element.title!
                  .toLowerCase()
                  .contains(event.search.toLowerCase()))
              .toList();

          emit(state.copyWith(status: EnumStatus.success, list: searchList));
        }).onError((exception) {
          emit(state.copyWith(
              status: EnumStatus.fail, message: exception.toString()));
        });
      } catch (e) {
        emit(state.copyWith(status: EnumStatus.fail, message: e.toString()));
      }
    } else {
      emit(state.copyWith(status: EnumStatus.fail, message: "No internet"));
    }
  }

  void _openPlayScreen(OpenDetailsScreen2 event, Emitter<FavouriteState> emit) {
    Navigator.push(
        event.context,
        MaterialPageRoute(
            builder: (context) =>
                PlayScreen(event.videoData, VideosStatus.homes)));
  }
}
