part of 'play_bloc.dart';

@immutable
abstract class PlayEvent {}

class Load extends PlayEvent {
  final VideosStatus status;
  final VideoData videoData;

  Load({required this.status, required this.videoData});
}

class ChangeVideo extends PlayEvent {
  final VideoData videoData;
  final BuildContext context;
  final VideosStatus status;

  ChangeVideo({required this.videoData, required this.context, required this.status});
}

enum VideosStatus { cookies, homes }
