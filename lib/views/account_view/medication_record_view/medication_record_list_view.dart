// import 'package:flutter/material.dart';
// import 'package:number_connection_test/services/crud/services/crud_service.dart';
// import 'package:number_connection_test/services/crud/models/users_and_records.dart';

// class MedicationListView extends StatefulWidget {
//   final String userId; // Assuming you pass the userId to this widget

//   MedicationListView({Key? key, required this.userId}) : super(key: key);

//   @override
//   _MedicationListViewState createState() => _MedicationListViewState();
// }

// class _MedicationListViewState extends State<MedicationListView> {
//   late Future<List<MedicationType>> _medications;

//   @override
//   void initState() {
//     super.initState();
//     _medications = Services().fetchMedications(widget.userId);
//   }

//   void _toggleMedication(MedicationType medication) {
//     setState(() {
//       medication.isTaken = !medication
//           .isTaken; // Assuming MedicationType has an isTaken property
//     });
//     Services().updateMedications(
//         widget.userId, [medication]); // Update the medication
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Daily Medications'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {
//                 _medications = Services().fetchMedications(widget.userId);
//               });
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<MedicationType>>(
//         future: _medications,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return ListView(
//               children: snapshot.data!
//                   .map((medication) => ListTile(
//                         title: Text(medication.name),
//                         subtitle: Text('Dosage: ${medication.dosage} pills'),
//                         trailing: Checkbox(
//                           value: medication.isTaken,
//                           onChanged: (bool? value) {
//                             _toggleMedication(medication);
//                           },
//                         ),
//                       ))
//                   .toList(),
//             );
//           } else {
//             return Center(child: Text('No medications found'));
//           }
//         },
//       ),
//     );
//   }
// }
