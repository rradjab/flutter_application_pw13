// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsStore on _ProductsStore, Store {
  late final _$productListAtom =
      Atom(name: '_ProductsStore.productList', context: context);

  @override
  List<int> get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(List<int> value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  late final _$_ProductsStoreActionController =
      ActionController(name: '_ProductsStore', context: context);

  @override
  void addProduct(int element) {
    final _$actionInfo = _$_ProductsStoreActionController.startAction(
        name: '_ProductsStore.addProduct');
    try {
      return super.addProduct(element);
    } finally {
      _$_ProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productList: ${productList}
    ''';
  }
}
