part of 'home_bloc.dart';

@immutable
class HomeState {
  final EnumStatus status;
  final List<VideoData> videosList;
  final String message;

  const HomeState({
    this.status = EnumStatus.initial,
    this.videosList = const [],
    this.message = ""
  });

  HomeState copyWith(
      {EnumStatus? status, List<VideoData>? list, String? message}) {
    return HomeState(
        status: status ?? this.status,
        videosList: list ?? videosList,
        message: message ?? this.message);
  }
}

enum EnumStatus { initial, success, fail, loading }
