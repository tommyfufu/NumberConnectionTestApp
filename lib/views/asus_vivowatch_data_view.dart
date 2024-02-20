import 'package:flutter/material.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/asus/model/asus_vivowatch_data.dart';
import 'package:number_connection_test/services/asus/service/asus_vivowatch_service.dart';
import 'package:number_connection_test/views/asus_data_list_view.dart';

class ASUSVivoWatchDataView extends StatefulWidget {
  const ASUSVivoWatchDataView({super.key});

  @override
  State<ASUSVivoWatchDataView> createState() => _ASUSVivoWatchDataViewState();
}

class _ASUSVivoWatchDataViewState extends State<ASUSVivoWatchDataView> {
  late Future<ASUSVivowatchData> data;

  @override
  void initState() {
    super.initState();
    data = ASUSVivowatchService().fetchData();
  }

  void _refreshData() {
    setState(() {
      data = ASUSVivowatchService().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globColor,
        title: const Text('ASUS VivoWatch 生理數據'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: _refreshData,
          ),
        ],
      ),
      extendBodyBehindAppBar: false,
      body: FutureBuilder<ASUSVivowatchData>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}\n請重新整理頁面'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return AsusDataListView(data: data);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
