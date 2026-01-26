import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jublicare/common/databaseHelper.dart';

import 'appointments_event.dart';
import 'appointments_state.dart';


class AppointmentsBloc
    extends Bloc<AppointmentsEvent, AppointmentsState> {

  List<File> _images = [];

  AppointmentsBloc() : super(AppointmentsInitial()) {

    on<AddImagesEvent>((event, emit) {
      _images.addAll(event.images);
      emit(ImagesUpdatedState(List.from(_images)));
    });

    on<RemoveImageEvent>((event, emit) {
      _images.removeAt(event.index);
      emit(ImagesUpdatedState(List.from(_images)));
    });

    on<SubmitImagesEvent>((event, emit) async {
      emit(SubmitLoadingState(List.from(_images)));


      try {
        for (int i = 0; i < _images.length; i++) {
          await Databasehelper.instance.insertData({
            "image": _images[i].path,
          }, "Data");
        }

        emit(SubmitSuccessState());
      } catch (e) {
        emit(SubmitErrorState(e.toString()));
      }
    });
  }
}
