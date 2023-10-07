part of 'favourite_bloc.dart';

@immutable
class FavouriteState {
  final EnumStatus status;
  final List<VideoData> videosList;
  final String message;

  const FavouriteState(
      {this.status = EnumStatus.initial,
      this.videosList = const [],
      this.message = ""});

  FavouriteState copyWith(
      {EnumStatus? status, List<VideoData>? list, String? message}) {
    return FavouriteState(
        status: status ?? this.status,
        videosList: list ?? videosList,
        message: message ?? this.message);
  }
}

enum EnumStatus { initial, success, fail, loading }
