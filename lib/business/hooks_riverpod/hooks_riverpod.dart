import 'package:hooks_riverpod/hooks_riverpod.dart';

final productsIdList =
    StateNotifierProvider<ProductsIdList, List<int>>((_) => ProductsIdList());

class ProductsIdList extends StateNotifier<List<int>> {
  ProductsIdList() : super([]);

  void addProduct(int id) => state = [...state, id];
}
