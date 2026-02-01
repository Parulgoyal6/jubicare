import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jublicare/common/databaseHelper.dart';
import 'package:jublicare/data/models/imagePojo.dart';
import 'package:jublicare/presentation/Appointments/appointments.dart';

import '../../bloc/appointments/appointments_bloc.dart';

class ListAppointments extends StatefulWidget {
  const ListAppointments({super.key});

  @override
  State<ListAppointments> createState() => _ListAppointmentsState();
}
class _ListAppointmentsState extends State<ListAppointments> {

  late Future<List<Imagepojo>> _futureData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _futureData = Databasehelper.instance
        .getData("SELECT * FROM Appointments");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointments")),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => AppointmentsBloc(),
                child: const Appointments(),
              ),
            ),
          );
          setState(() {
            _loadData();
          });
        },
      ),

      body: FutureBuilder<List<Imagepojo>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Appointments Found"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return Card(
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.className),
                  leading: Image.file(
                    File(item.image),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
