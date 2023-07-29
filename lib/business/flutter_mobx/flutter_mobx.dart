import 'package:mobx/mobx.dart';

part 'flutter_mobx.g.dart';

// ignore: library_private_types_in_public_api
class ProductsStore = _ProductsStore with _$ProductsStore;

abstract class _ProductsStore with Store {
  @observable
  List<int> productList = [];

  @action
  void addProduct(int element) {
    productList = [...productList, element];
    //productList = ObservableList<int>.of([...productList, element]);
  }
}
