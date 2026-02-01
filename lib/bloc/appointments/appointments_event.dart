import 'dart:io';

abstract class AppointmentsEvent {}

class AddImagesEvent extends AppointmentsEvent {
  final List<File> images;
  AddImagesEvent(this.images);
}

class RemoveImageEvent extends AppointmentsEvent {
  final int index;
  RemoveImageEvent(this.index);
}

class SubmitImagesEvent extends AppointmentsEvent {
  final String name;
  final String className;

  SubmitImagesEvent({
    required this.name,
    required this.className,
  });
}
