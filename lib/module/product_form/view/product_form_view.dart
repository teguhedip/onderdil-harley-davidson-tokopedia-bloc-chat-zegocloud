import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:example/core.dart';

class ProductFormView extends StatefulWidget {
  int? index;
  Map? item;

  ProductFormView({Key? key, this.index, this.item}) : super(key: key);

  Widget build(context, ProductFormController controller) {
    controller.view = this;

    controller.editMode = item != null ? true : false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("GjProductForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              QImagePicker(
                label: "Photo",
                hint: "Your photo",
                //validator: Validator.required,
                value: controller.editMode ? item!["photo"] : null,
                onChanged: (value) {
                  controller.imageUrl = value;
                },
              ),
              QTextField(
                label: "Product name",
                //validator: Validator.required,
                value: controller.editMode ? item!["product_name"] : null,
                onChanged: (val) {
                  log("val Product name $val");
                  controller.productName = val;
                },
              ),
              QNumberField(
                label: "Price",
                //validator: Validator.required,
                value: controller.editMode ? item!["price"].toString() : null,
                onChanged: (val) {
                  controller.price = int.parse(val);
                },
              ),
              QNumberField(
                label: "Quantity",
                //validator: Validator.required,
                value:
                    controller.editMode ? item!["quantity"].toString() : null,
                onChanged: (val) {
                  controller.quantity = int.parse(val);
                },
              ),
              QTextField(
                label: "Category",
                //validator: Validator.required,
                value: controller.editMode ? item!["category"] : null,
                onChanged: (value) {
                  controller.category = value;
                },
              ),
              QTextField(
                label: "Description",
                //validator: Validator.required,
                value: controller.editMode ? item!["description"] : null,
                onChanged: (value) {
                  controller.description = value;
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: controller.editMode
                    ? const Text("Update")
                    : const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.editMode
                      ? Colors.orange[700]
                      : Colors.blue[800],
                ),
                onPressed: () {
                  controller.editMode
                      ? controller.update(index, item)
                      : controller.add();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<ProductFormView> createState() => ProductFormController();
}
