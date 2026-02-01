import 'dart:io';

abstract class AppointmentsState {
  final List<File> images;
  const AppointmentsState(this.images);
}

class AppointmentsInitial extends AppointmentsState {
  const AppointmentsInitial({List<File> images = const []}) : super(images);
}

class ImagesUpdatedState extends AppointmentsState {
  const ImagesUpdatedState(List<File> images) : super(images);
}

class SubmitLoadingState extends AppointmentsState {
  const SubmitLoadingState(List<File> images) : super(images);
}

class SubmitSuccessState extends AppointmentsState {
  const SubmitSuccessState() : super(const []);
}

class SubmitErrorState extends AppointmentsState {
  final String message;
  const SubmitErrorState(this.message, List<File> images) : super(images);
}
