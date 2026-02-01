import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jublicare/common/app_colors.dart';

import '../../bloc/appointments/appointments_bloc.dart';
import '../Appointments/ListAppointments.dart';
import '../Appointments/appointments.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Map<String, dynamic>> cardData = [
    {
      "title": "Appointments",
      "icon": Icons.calendar_month,
      "color": Colors.blue,
      "page":  ListAppointments(),
    },
    {
      "title": "Doctor to Address Appointment",
      "icon": Icons.medical_services,
      "color": Colors.blue,
      "page":  Appointments(),
    },
    {
      "title": "Medicine to be delivered",
      "icon": Icons.local_shipping,
      "color": Colors.blue,
      "page":  Appointments(),
    },
    {
      "title": "Attendance",
      "icon": Icons.file_present,
      "color": Colors.blue,
      "page":  Appointments(),
    },
    {
      "title": "Nutrition Growth",
      "icon": Icons.assessment,
      "color": Colors.blue,
      "page":  Appointments(),
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Stack(
          children: const [
            Align(alignment: Alignment.centerLeft, child: Icon(Icons.menu, color: Colors.white)),
            Center(child: Text("Home", style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 240,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
          ),

          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: AppColors.primary, size: 30),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello ", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    Text("My Profile", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 170), // start after profile
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: cardData.length,
              itemBuilder: (context, index) {
                final item = cardData[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ListAppointments(),
                        ),
                      );
                    },

                    child:Card(
                    color: AppColors.bg1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                    child: Container(
                      height: 120,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(item["icon"], color: item["color"], size: 40),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              item["title"],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
