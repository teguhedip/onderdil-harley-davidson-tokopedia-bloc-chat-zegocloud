import 'dart:developer';

import 'package:example/module/product_form/view/product_form_view.dart';
import 'package:flutter/material.dart';
import 'package:example/state_util.dart';
import '../view/product_list_view.dart';

class ProductListController extends State<ProductListView>
    implements MvcController {
  static late ProductListController instance;
  late ProductListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  add() async {
    Get.to(const ProductFormView());

    log("Tambah produk");
    setState(() {});
  }
}
