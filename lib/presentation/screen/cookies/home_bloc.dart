import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_palyer_app/data/model/video_data.dart';
import 'package:video_palyer_app/data/source/remote/api/first_api.dart';
import 'package:video_palyer_app/presentation/screen/play/play_bloc.dart';
import 'package:video_palyer_app/presentation/screen/play/play_screen.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirstApi _api;

  HomeBloc(this._api) : super(const HomeState()) {
    on<HomeEvent>((event, emit) async {
      switch (event) {
        case Load():
          await _onLoadData(event, emit);
          break;
        case OpenDetailsScreen():
          _openPlayScreen(event, emit);
          break;
      }
    });
  }

  Future<void> _onLoadData(Load event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: EnumStatus.loading));
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final list = <VideoData>[];
        list.addAll(state.videosList);
        (await _api.getFirstVideoList()).onSuccess((list) {
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

  void _openPlayScreen(OpenDetailsScreen event, Emitter<HomeState> emit) {
    Navigator.push(
        event.context,
        MaterialPageRoute(
            builder: (context) => PlayScreen(event.videoData, VideosStatus.cookies)));

  }
}
