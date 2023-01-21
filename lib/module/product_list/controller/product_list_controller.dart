import 'package:flutter/material.dart';
import 'package:example/state_util.dart';
import '../view/product_list_view.dart';

class ProductListController extends State<ProductListView>
    implements MvcController {
  static late ProductListController instance;
  late ProductListView view;

  // late final products;

  // final productsCubit = BlocProvider.of<ProductListCubit>(Get.currentContext);

  @override
  void initState() {
    instance = this;
    // products = LocalProductService.products;
    // productsCubit.getProducts();

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  // add() async {
  //   Get.to(ProductFormView());
  //   setState(() {});
  // }

  // delete(Map item) async {
  //   bool confirmation = await showConfirmationDialog();
  //   if (confirmation) {
  //     await LocalProductService.delete(item);
  //   }
  //   setState(() {});
  // }

  // update(int index, Map item) {
  //   Get.to(ProductFormView(
  //     index: index,
  //     item: item,
  //   ));
  // }
}
