// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_list_cubit.dart';

@immutable
abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List products;
  ProductListSuccess({
    required this.products,
  });
}
