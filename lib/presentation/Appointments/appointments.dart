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
    final nameController = TextEditingController();
    final classController = TextEditingController();

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
            SmartDialog.showToast(state.message);
          }

          if (state is SubmitSuccessState) {
            SmartDialog.dismiss();
            Future.microtask(() {
              Navigator.of(context).pop(true);
            });
          }

        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text("Name"),
              TextFormField(controller: nameController),

              const SizedBox(height: 12),

              const Text("Class"),
              TextFormField(controller: classController),

              const SizedBox(height: 16),

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
                child: const Icon(Icons.photo, size: 40,),
              ),

              const SizedBox(height: 12),

              BlocBuilder<AppointmentsBloc, AppointmentsState>(
                builder: (context, state) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(state.images.length, (index) {
                      return Stack(
                        children: [
                          Image.file(
                            state.images[index],
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
                              child: const Icon(Icons.close, color: Colors.red),
                            ),
                          )
                        ],
                      );
                    }),
                  );
                },
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        classController.text.isEmpty) {
                      SmartDialog.showToast("Fill all fields");
                      return;
                    }

                    bloc.add(
                      SubmitImagesEvent(
                        name: nameController.text.trim(),
                        className: classController.text.trim(),
                      ),
                    );
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
