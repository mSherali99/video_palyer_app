part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class Load extends HomeEvent {
  final String search;

  Load({required this.search});
}

class OpenDetailsScreen extends HomeEvent {
  final VideoData videoData;
  final BuildContext context;

  OpenDetailsScreen({required this.videoData, required this.context});
}

