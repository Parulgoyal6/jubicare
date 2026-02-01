import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jublicare/common/databaseHelper.dart';

import 'appointments_event.dart';
import 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final List<File> _images = [];

  AppointmentsBloc() : super(const AppointmentsInitial()) {

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
        for (final img in _images) {
          await Databasehelper.instance.insertData({
            "name": event.name,
            "className": event.className,
            "image": img.path,
          }, "Appointments");
        }

        _images.clear();
        emit(const SubmitSuccessState());
        emit(const AppointmentsInitial());
      } catch (e) {
        emit(SubmitErrorState(e.toString(), List.from(_images)));
      }
    });
  }
}
