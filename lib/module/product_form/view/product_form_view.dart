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
                validator: Validator.required,
                value:
                    controller.editMode ? item!["photo"] : controller.imageUrl,
                onChanged: (value) {
                  controller.imageUrl = value;
                },
              ),
              QTextField(
                label: "Product name",
                validator: Validator.required,
                value: controller.editMode
                    ? item!["product_name"]
                    : controller.productName,
                onChanged: (val) {
                  // print("Procut Name $val");
                  controller.productName = val;
                },
              ),
              QNumberField(
                label: "Price | USD",
                validator: Validator.required,
                value: controller.editMode
                    ? item!["price"].toString()
                    : controller.price.toString(), //int.tryParse(value) ?? 0;
                onChanged: (val) {
                  controller.price = double.parse(val) ?? 0;
                },
              ),
              QNumberField(
                label: "Quantity",
                validator: Validator.required,
                value: controller.editMode
                    ? item!["quantity"].toString()
                    : controller.quantity.toString(),
                onChanged: (val) {
                  controller.quantity = int.parse(val) ?? 0;
                },
              ),
              QTextField(
                label: "Category",
                validator: Validator.required,
                value: controller.editMode
                    ? item!["category"]
                    : controller.category,
                onChanged: (value) {
                  controller.category = value;
                },
              ),
              QTextField(
                label: "Description",
                validator: Validator.required,
                maxLength: 300,
                value: controller.editMode
                    ? item!["description"]
                    : controller.description,
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
