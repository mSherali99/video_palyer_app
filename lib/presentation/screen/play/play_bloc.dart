import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:video_palyer_app/data/model/video_data.dart';
import 'package:video_palyer_app/data/source/remote/api/first_api.dart';
import 'package:video_palyer_app/data/source/remote/api/second_api.dart';
import 'package:video_palyer_app/presentation/screen/play/play_screen.dart';

part 'play_event.dart';

part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(const PlayState(currentVideo: null)) {
    on<PlayEvent>((event, emit) async{
      switch (event) {
        case Load():
          await _onLoadData(event, emit);
          break;
        case ChangeVideo():
          await _changeVideo(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoadData(Load event, Emitter<PlayState> emit) async {
    emit(
      state.copyWith(videoData: event.videoData, status: EnumStatus.loading),
    );
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final list = <VideoData>[];
        list.addAll(state.videosList);
        final getIt = GetIt.I;

        if (event.status == VideosStatus.cookies) {
          final api = getIt.get<FirstApi>();
          (await api.getFirstVideoList()).onSuccess((list) {
            List<VideoData> searchList = list
                .where((element) => element.videoId != event.videoData.videoId)
                .toList();
            emit(state.copyWith(status: EnumStatus.success, list: searchList));
          }).onError((exception) {
            emit(state.copyWith(
                status: EnumStatus.fail, message: exception.toString()));
          });
        } else if (event.status == VideosStatus.homes) {
          final api = getIt.get<SecondApi>();
          (await api.getSecondVideoList()).onSuccess((list) {
            List<VideoData> searchList = list
                .where((element) => element.videoId != event.videoData.videoId)
                .toList();
            emit(state.copyWith(status: EnumStatus.success, list: searchList));
          }).onError((exception) {
            emit(state.copyWith(
                status: EnumStatus.fail, message: exception.toString()));
          });
        }
      } catch (e) {
        emit(state.copyWith(status: EnumStatus.fail, message: ""));
      }
    } else {
      emit(state.copyWith(status: EnumStatus.fail, message: "No internet"));
    }
  }

  Future<void> _changeVideo(ChangeVideo event, Emitter<PlayState> emit) async {
    print("shu yer");
    Navigator.of(event.context).pushReplacement(
      MaterialPageRoute(builder: (context) => PlayScreen(event.videoData, event.status)),
    );
    // Navigator.pushReplacement(event.context, PlayScreen(event.videoData, event.status));
    /*Navigator.replace(
        event.context,
        MaterialPageRoute(
            builder: (context) => PlayScreen(event.videoData, VideosStatus.cookies)));*/
    emit(state.copyWith(videoData: event.videoData));
  }
}
