part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class Loading extends FavouriteEvent {
  final String search;

  Loading({required this.search});
}

class OpenDetailsScreen2 extends FavouriteEvent {
  final VideoData videoData;
  final BuildContext context;

  OpenDetailsScreen2({required this.videoData, required this.context});
}

