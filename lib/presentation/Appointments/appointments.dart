
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jublicare/common/app_colors.dart';

class Appointments extends StatelessWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Appointments Status'),backgroundColor: AppColors.primary,),
    );
  }
}
