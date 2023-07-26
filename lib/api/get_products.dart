import 'package:dio/dio.dart';
import 'package:flutter_application_pw13/model/products.dart';

Future<List<Products>?> getProducts() async {
  String url = 'https://dummyjson.com/products?limit=30';
  var response = await Dio().get(url);

  if (response.statusCode == 200) {
    return DummyAPI.fromJson(response.data).products;
  }
  return [];
}
