part of 'play_bloc.dart';

@immutable
class PlayState {
  final EnumStatus status;
  final List<VideoData> videosList;
  final String message;
  final VideoData ?currentVideo;

  const PlayState(
      {this.status = EnumStatus.initial,
      this.videosList = const [],
      this.message = "",
      this.currentVideo});

  PlayState copyWith(
      {EnumStatus? status,
      List<VideoData>? list,
      String? message,
      VideoData? videoData}) {
    return PlayState(
        status: status ?? this.status,
        videosList: list ?? videosList,
        message: message ?? this.message,
        currentVideo: videoData ?? currentVideo);
  }
}

enum EnumStatus { initial, success, fail, loading }
