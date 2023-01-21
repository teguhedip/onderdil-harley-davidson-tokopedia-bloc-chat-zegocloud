import 'package:flutter/material.dart';
import 'package:example/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/product_list_cubit/product_list_cubit.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  Widget build(context, ProductListController controller) {
    controller.view = this;

    // final prdCbt = controller.productsCubit;
    final prdCbt = BlocProvider.of<ProductListCubit>(context);
    prdCbt.getProducts();

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
              // onPressed: () => controller.add(),
              onPressed: () => prdCbt.add(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              BlocBuilder<ProductListCubit, ProductListState>(
                bloc: prdCbt,
                builder: (context, state) {
                  if (state is ProductListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ProductListSuccess) {
                    return ListView.builder(
                      // itemCount: controller.products.length,
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        print("isi product bloc ${state.products.length}");
                        var item = state.products[index];
                        // print("ITEM ID ${item["id"]}");
                        return InkWell(
                          onTap: () {
                            prdCbt.delete(item);
                            controller.setState(() {});
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
                                onPressed: () => prdCbt.update(index, item),
                                icon: const Icon(
                                  Icons.edit,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
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
