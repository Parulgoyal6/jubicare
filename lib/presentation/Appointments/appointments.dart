import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../bloc/appointments/appointments_bloc.dart';
import '../../bloc/appointments/appointments_event.dart';
import '../../bloc/appointments/appointments_state.dart';

class Appointments extends StatelessWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppointmentsBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("Appointments")),
      body: BlocListener<AppointmentsBloc, AppointmentsState>(
        listener: (context, state) {
          if (state is SubmitLoadingState) {
            SmartDialog.showLoading();
          } else {
            SmartDialog.dismiss();
          }

          if (state is SubmitErrorState) {
            SmartDialog.showToast(state.message!);
          }

          if (state is SubmitSuccessState) {
            SmartDialog.showToast("Submitted Successfully ✅");
          }
        },
        child: Column(
          children: [

            ElevatedButton(
              onPressed: () async {
                final res = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg', 'jpeg'],
                );

                if (res == null) return;

                final files = res.files
                    .where((e) => e.path != null)
                    .map((e) => File(e.path!))
                    .toList();

                bloc.add(AddImagesEvent(files));
              },
              child: const Text("Pick Images"),
            ),

            BlocBuilder<AppointmentsBloc, AppointmentsState>(
              builder: (context, state) {
                List<File> images = [];

                if (state is ImagesUpdatedState) {
                  images = state.images;
                }
                else if (state is AppointmentsInitial) {
                  images = state.images;
                }

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(images.length, (index) {
                    return Stack(
                      children: [
                        Image.file(
                          images[index],
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<AppointmentsBloc>()
                                  .add(RemoveImageEvent(index));
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                );
              },
            ),

            ElevatedButton(
              onPressed: () {
                bloc.add(SubmitImagesEvent());
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
