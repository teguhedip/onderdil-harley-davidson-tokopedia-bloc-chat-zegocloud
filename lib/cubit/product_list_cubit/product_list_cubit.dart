import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../module/product_form/view/product_form_view.dart';
import '../../service/local_product_service.dart';
import '../../shared/util/dialog/confirmation_dialog.dart';
import '../../state_util.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());

  void getProducts() async {
    emit(ProductListLoading());

    final response = LocalProductService.products;
    print("isi dari response bloc => ${response.length}");

    emit(ProductListSuccess(products: response));
  }

  void add() async {
    Get.to(ProductFormView());
    print("isi add Cubit dialankan");
  }

  void delete(Map item) async {
    bool confirmation = await showConfirmationDialog();
    if (confirmation) {
      await LocalProductService.delete(item);
    }
    getProducts();
    print("isi cubit Delete dijalnkan");
  }

  void update(int index, Map item) {
    Get.to(ProductFormView(
      index: index,
      item: item,
    ));
  }
}
