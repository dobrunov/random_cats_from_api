part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final String catFactsText;
  final String catFactsCreatedAt;
  final Uint8List rawImage;

  const HomeLoadedState(
      this.catFactsText, this.catFactsCreatedAt, this.rawImage);
  @override
  List<Object?> get props => [catFactsText, catFactsCreatedAt, rawImage];
}

class HomeNoInternetState extends HomeState {
  @override
  List<Object?> get props => [];
}
