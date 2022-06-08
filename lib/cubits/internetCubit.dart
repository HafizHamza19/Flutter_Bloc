import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//if there no data in class so use enum class.
enum InternetStateCubit { initial, lost, gained }

class InternetCubit extends Cubit<InternetStateCubit> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _streamSubscription;
  InternetCubit() : super(InternetStateCubit.initial) {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        emit(InternetStateCubit.gained);
      } else {
        emit(InternetStateCubit.lost);
      }
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    _streamSubscription?.cancel();
    return super.close();
  }
}
