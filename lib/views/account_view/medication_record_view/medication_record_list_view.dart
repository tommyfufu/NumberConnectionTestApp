import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/crud/services/crud_service.dart';
import 'package:number_connection_test/services/crud/models/users_and_records.dart';

class MedicationListView extends StatefulWidget {
  final String userId;
  const MedicationListView({super.key, required this.userId});

  @override
  State<MedicationListView> createState() => _MedicationListViewState();
}

class _MedicationListViewState extends State<MedicationListView> {
  late Future<List<MedicationType>> _medications;

  @override
  void initState() {
    super.initState();
    _medications = Services().fetchMedications(widget.userId);
  }

  void _toggleMedication(MedicationType medication) {
    setState(() {
      medication.isTaken = !medication.isTaken;
    });
    Services().updateMedications(widget.userId, [medication]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globColor,
        title: Text(
          '每日用藥',
          style: TextStyle(fontSize: 20.sp),
        ),
        toolbarHeight: 60.h,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _medications = Services().fetchMedications(widget.userId);
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<MedicationType>>(
        future: _medications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!
                  .map((medication) => ListTile(
                        title: Text(
                          medication.name,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        subtitle: Text(
                          '劑量: ${medication.dosage} 份/顆 次數: 一天${medication.frequency} 次',
                          style: TextStyle(fontSize: 10.sp),
                        ),
                        trailing: Checkbox(
                          value: medication.isTaken,
                          onChanged: (bool? value) {
                            _toggleMedication(medication);
                          },
                        ),
                      ))
                  .toList(),
            );
          } else {
            return const Center(child: Text('無用藥紀錄'));
          }
        },
      ),
    );
  }
}
