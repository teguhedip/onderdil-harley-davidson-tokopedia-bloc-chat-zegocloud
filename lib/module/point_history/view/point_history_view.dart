import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/cubit/history_cubit/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:example/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointHistoryView extends StatefulWidget {
  const PointHistoryView({Key? key}) : super(key: key);

  Widget build(context, PointHistoryController controller) {
    controller.view = this;

    // final historyCubit = context.read<HistoryCubit>();
    final historyCubit = BlocProvider.of<HistoryCubit>(context);
    historyCubit.getHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text("GjPointHistory"),
        actions: [
          IconButton(
            onPressed: () {
              controller.pirntHistory();
              controller.setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: AuthService.isMember
              ? StreamBuilder(
                  stream: controller.pointRecords,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('No Data...');

                    if (snapshot.hasError) {
                      return const Text("Error... something wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading....");
                    }

                    final List firebaseData = [];
                    snapshot.data?.docs
                        .map((DocumentSnapshot documentSnapshot) {
                      Map store =
                          documentSnapshot.data() as Map<String, dynamic>;
                      firebaseData.add(store);
                      store['id'] = documentSnapshot.id;
                      print("documentSnapshot ===== $documentSnapshot.id");
                    }).toList();

                    return ListView.builder(
                      itemCount: firebaseData.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        // var item = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 22, 159, 227),
                              child: Text("${index + 1}"),
                            ),
                            title: Text(
                              "Vendor ${firebaseData[index]['user']['email']} ",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                                "Total ${firebaseData[index]['total']} Point: ${firebaseData[index]['point'].toStringAsFixed(2)}"),
                          ),
                        );
                      },
                    );
                  })
              : SizedBox(
                  height: 600,
                  child: BlocBuilder<HistoryCubit, HistoryState>(
                    bloc: historyCubit,
                    builder: (context, state) {
                      if (state is HistoryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is HistorySucess) {
                        return ListView.builder(
                          itemCount: state.pointHistory.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = state.pointHistory[index];

                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Text("${index + 1}"),
                                ),
                                title: Text(
                                  "Vendor: ${item["vendor"]}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                    "total ${item["total"].toStringAsFixed(2)} point: ${item["point"].toStringAsFixed(2)} "),
                              ),
                            );
                          },
                        );
                      }
                      return Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            "No Data...",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
        ),
      ),
    );
  }

  @override
  State<PointHistoryView> createState() => PointHistoryController();
}
