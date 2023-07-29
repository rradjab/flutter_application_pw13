import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_application_pw13/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_pw13/dialogs/cart_items.dart';

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

class MobxExample extends StatelessWidget {
  MobxExample({super.key});
  final ProductsStore productsStore = ProductsStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CarouselSlider(
                            options: CarouselOptions(),
                            items: products?[index]
                                .images!
                                .map((item) => Center(
                                        child: Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                    )))
                                .toList(),
                          ),
                        ),
                        Center(
                          child: Text(
                            products?[index].title ?? 'Loading Title',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            products?[index].description ?? 'Loading Desc',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Discount Percentage: ${products?[index].discountPercentage}'),
                              Text('Rating: ${products?[index].rating}'),
                              Text('Brand: ${products?[index].brand}'),
                              Text('Category: ${products?[index].category}'),
                              Text('Stock: ${products?[index].stock}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Price: ${products?[index].price}\$'),
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        productsStore
                                            .addProduct(products![index].id!);
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      icon: const Icon(Icons.add),
                                      label: const Text('Добавить в корзину'))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: products?.length ?? 0,
            ),
          ),
        ],
      ),
      floatingActionButton: Observer(
        builder: (context) {
          return FloatingActionButton.extended(
            onPressed: () {
              showItems(context, productsStore.productList, products);
            },
            icon: const Icon(Icons.shopping_cart),
            label: Text(productsStore.productList.isEmpty
                ? ''
                : productsStore.productList.length.toString()),
          );
        },
      ),
    );
  }
}
