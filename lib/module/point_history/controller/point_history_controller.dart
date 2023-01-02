import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core.dart';
import 'package:flutter/material.dart';

class PointHistoryController extends State<PointHistoryView>
    implements MvcController {
  static late PointHistoryController instance;
  late PointHistoryView view;

  // final Stream<QuerySnapshot> pointRecords = FirebaseFirestore.instance.collection('points').snapshots();
  late Stream<QuerySnapshot> pointRecords;
  late final dataLocalHistory = LocalHistoryService.point;
  @override
  void initState() {
    instance = this;
    pointRecords = FirebaseFirestore.instance.collection('points').snapshots();

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  pirntHistory() {
    // print("data history **** $dataLocalHistory");
    log("Print history 888888888");
    log("Print history 888 $dataLocalHistory");
  }
}
