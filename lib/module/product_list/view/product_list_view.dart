import 'package:flutter/material.dart';
import 'package:example/core.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  Widget build(context, ProductListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("GjProductList"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Add"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 12, 12),
              ),
              onPressed: () => controller.add(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListView.builder(
                itemCount: controller.products.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var item = controller.products[index];
                  print("ITEM ID ${item["id"]}");
                  return InkWell(
                    onTap: () {
                      controller.delete(item);
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(
                            item["photo"],
                          ),
                        ),
                        title: Text("${item["product_name"]} "),
                        subtitle: Row(
                          children: [
                            Text("USD ${item["price"]}"),
                            const Spacer(),
                            Text("(stock:${item["quantity"]})"),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () => controller.update(index, item),
                          icon: const Icon(
                            Icons.edit,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<ProductListView> createState() => ProductListController();
}
