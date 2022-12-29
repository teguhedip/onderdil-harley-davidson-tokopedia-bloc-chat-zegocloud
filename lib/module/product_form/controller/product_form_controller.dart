import 'package:flutter/material.dart';
import "package:example/core.dart";

class ProductFormController extends State<ProductFormView>
    implements MvcController {
  static late ProductFormController instance;
  late ProductFormView view;

  late int id;
  late String imageUrl;
  late String productName;
  late int price;
  late int quantity;
  late String category;
  late String description;
  bool editMode = false;

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
    LocalProductService.add(
      {
        "id": const Uuid(),
        "photo": imageUrl,
        "product_name": productName,
        "price": price,
        "quantity": quantity,
        "category": category,
        "description": description,
      },
    );

    setState(() {});
    Get.back();
    showInfoDialog("Success Add Product");
  }

  update(index, item) async {
    LocalProductService.update(index, item);

    print("ITEM ========= $item");
    setState(() {});

    Get.back();
    showInfoDialog("Update Success");
  }
}
