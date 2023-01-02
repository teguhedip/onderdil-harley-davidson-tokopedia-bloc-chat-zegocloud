import 'package:flutter/material.dart';
import "package:example/core.dart";

class ProductFormController extends State<ProductFormView>
    implements MvcController {
  static late ProductFormController instance;
  late ProductFormView view;

  int? id;
  String? imageUrl;
  String? productName;
  double price = 0;
  int quantity = 0;
  String? category;
  String? description;
  bool editMode = false;

  var uuid = const Uuid();

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
        "id": uuid.v4(),
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
    item["photo"] = imageUrl ?? item["photo"];
    item["product_name"] = productName ?? item["product_name"];
    item["price"] = price > 0 ? price : item["price"];
    item["quantity"] = quantity > 0 ? quantity : item["quantity"];
    item["category"] = category ?? item["category"];
    item["description"] = description ?? item["description"];

    // print(" Price ======= $price");

    // print(" ======= $quantity");
    // print(" ======= $category");
    // print(" ======= $description");

    LocalProductService.update(index, item);

    print("ITEM ========= $item");
    setState(() {});

    Get.back();
    showInfoDialog("Update Success");
  }
}
