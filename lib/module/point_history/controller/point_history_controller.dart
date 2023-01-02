import 'package:example/core.dart';
import 'package:flutter/material.dart';

class PointHistoryController extends State<PointHistoryView>
    implements MvcController {
  static late PointHistoryController instance;
  late PointHistoryView view;

  late Stream<List> stream;

  @override
  void initState() {
    instance = this;
    stream = dataPoint();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  Stream<List> dataPoint() async* {
    yield LocalHistoryService.point;
  }
}
