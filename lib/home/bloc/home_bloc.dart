import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/cat_facts_service.dart';
import '../../services/connectivity_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CatFactsService _catFactsService;
  final ConnectivityService _connectivityService;

  HomeBloc(this._catFactsService, this._connectivityService)
      : super(HomeLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print('without internet');
        add(NoInternetEvent());
      } else {
        print('with internet');
        add(LoadApiEvent());
      }
    });

    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      final catFacts = await _catFactsService.getCatFacts();
      final rawImage = await _catFactsService.getCatImage();
      emit(HomeLoadedState(catFacts.text, catFacts.createdAt, rawImage));
    });

    on<NoInternetEvent>((event, emit) {
      emit(HomeNoInternetState());
    });
  }
}
