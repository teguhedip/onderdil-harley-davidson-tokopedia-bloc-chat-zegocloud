import 'package:example/service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:example/core.dart';

class PosView extends StatefulWidget {
  const PosView({Key? key}) : super(key: key);

  Widget build(context, PosController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("GjPos"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: OrderService.products.length,
                itemBuilder: (context, index) {
                  var item = OrderService.products[index];
                  item["qty"] = item["qty"] ?? 0;
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(
                          item["photo"],
                        ),
                      ),
                      title: Text("${item["product_name"]}"),
                      subtitle: Text(
                          "${item["price"]} USD | stock: ${item["quantity"]} "),
                      trailing: SizedBox(
                        width: 120.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 12.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    if (item["qty"] > 0) {
                                      item["quantity"]++;
                                      item["qty"]--;
                                      controller.countPoin();
                                      controller.setState(() {});
                                      // controller.totalProduct(
                                      //     item["qty"], item["price"]);
                                      //tambah qty
                                    }
                                    // kurangi totalProducto
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 9.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${item["qty"]}",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 12.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    if (item["quantity"] > 0) {
                                      item["quantity"]--;
                                      item["qty"]++;
                                      controller.countPoin();
                                      controller.setState(() {});

                                      // controller.totalProduct(
                                      //     item["qty"], item["price"]);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 9.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Payment",
                      hint: "Your payment method",
                      validator: Validator.required,
                      value: "Cash",
                      items: const [
                        {
                          "label": "Cash",
                          "value": "cash",
                        },
                        {
                          "label": "OVO",
                          "value": "ovo",
                        },
                        {
                          "label": "Dana",
                          "value": "dana",
                        },
                        {
                          "label": "Gopay",
                          "value": "gopay",
                        }
                      ],
                      onChanged: (value, label) {
                        controller.paymentMethod = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Total: ${OrderService.total}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Poin (10%): ${controller.poin.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(MdiIcons.checkCircle),
                label: const Text("Checkout"),
                onPressed: () => controller.doCheckout(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<PosView> createState() => PosController();
}
