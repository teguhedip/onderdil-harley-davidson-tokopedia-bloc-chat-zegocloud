import 'dart:math';

import 'package:example/module/product_form/view/product_form_view.dart';
import 'package:example/service/local_product_service.dart';
import 'package:example/shared/util/dialog/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:example/state_util.dart';
import '../view/product_list_view.dart';

class ProductListController extends State<ProductListView>
    implements MvcController {
  static late ProductListController instance;
  late ProductListView view;

  late final products;

  @override
  void initState() {
    instance = this;
    products = LocalProductService.products;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  add() async {
    Get.to(const ProductFormView());
    setState(() {});
  }

  delete(Map item) async {
    bool confirmation = await showConfirmationDialog();
    if (confirmation) {
      await LocalProductService.delete(item);
    }
    setState(() {});
  }

  update(int index, Map item) {
    item["price"] = Random().nextInt(100);
    LocalProductService.update(index, item);
    setState(() {});
  }
}
