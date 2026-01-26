import 'dart:io';

abstract class AppointmentsState {
  final List<File> images;
  const AppointmentsState({this.images = const []});
}

// Initial
class AppointmentsInitial extends AppointmentsState {
  const AppointmentsInitial() : super(images: const []);
}

// Images updated
class ImagesUpdatedState extends AppointmentsState {
  const ImagesUpdatedState(List<File> images) : super(images: images);
}

// Loading
class SubmitLoadingState extends AppointmentsState {
  const SubmitLoadingState(List<File> images) : super(images: images);
}

// Success
class SubmitSuccessState extends AppointmentsState {
  const SubmitSuccessState() : super();
}

// Error
class SubmitErrorState extends AppointmentsState {
  final String message;
  const SubmitErrorState(this.message) : super();
}
