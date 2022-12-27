import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:example/core.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({Key? key}) : super(key: key);

  Widget build(context, ProductFormController controller) {
    controller.view = this;

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
              /* 
              1. image avatar
              2. Name
              3. Price
              4. Qty
              5. Category
              6. Descriptin
               */

              QImagePicker(
                label: "Product image",
                onChanged: (val) {
                  controller.imageUrl = val;
                },
              ),
              QTextField(
                label: "Product name",
                validator: Validator.required,
                onChanged: (val) {
                  log("val Product name $val");
                  controller.productName = val;
                },
              ),
              QNumberField(
                label: "Price",
                validator: Validator.required,
                onChanged: (val) {
                  log("val Price $val");
                  controller.price = int.parse(val);
                },
              ),
              QNumberField(
                label: "Quantity",
                validator: Validator.required,
                onChanged: (val) {
                  log("val QTY $val");
                  controller.quantity = int.parse(val);
                },
              ),
              QTextField(
                label: "Category",
                validator: Validator.required,
                onChanged: (value) {
                  controller.category = value;
                },
              ),
              QTextField(
                label: "Description",
                validator: Validator.required,
                onChanged: (value) {
                  controller.description = value;
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
                onPressed: () {
                  controller.add();
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
