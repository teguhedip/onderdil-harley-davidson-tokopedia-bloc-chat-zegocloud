import 'package:flutter/material.dart';
import 'package:example/core.dart';
import '../controller/point_history_controller.dart';

class PointHistoryView extends StatefulWidget {
  const PointHistoryView({Key? key}) : super(key: key);

  Widget build(context, PointHistoryController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("GjPointHistory"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: controller.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('No Data...');

                if (snapshot.hasError) {
                  return const Text("Error... something wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading....");
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = snapshot.data![index];
                    return Card(
                      child: ListTile(
                        title: Text("Vendor : ${item["vendor"]}"),
                        subtitle: Text(
                            "Total ${item["total"]} Point: ${item["point"].toStringAsFixed(2)}"),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

  @override
  State<PointHistoryView> createState() => PointHistoryController();
}
