import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pw13/api/get_products.dart';
import 'package:flutter_application_pw13/dialogs/cart_items.dart';
import 'package:flutter_application_pw13/model/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsIdList = StateProvider<List<int>>((ref) => []);

class RiverpodExample extends ConsumerWidget {
  const RiverpodExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productIds = ref.watch(productsIdList);
    List<Products>? products;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FutureBuilder<List<Products>?>(
              future: getProducts(),
              builder: (context, snapshot) {
                products = snapshot.data;
                return snapshot.hasData
                    ? SliverList(
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
                                        products?[index].title ??
                                            'Loading Title',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        products?[index].description ??
                                            'Loading Desc',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Discount Percentage: ${products?[index].discountPercentage}'),
                                          Text(
                                              'Rating: ${products?[index].rating}'),
                                          Text(
                                              'Brand: ${products?[index].brand}'),
                                          Text(
                                              'Category: ${products?[index].category}'),
                                          Text(
                                              'Stock: ${products?[index].stock}'),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'Price: ${products?[index].price}\$'),
                                              ElevatedButton.icon(
                                                  onPressed: () {
                                                    ref
                                                        .read(productsIdList
                                                            .notifier)
                                                        .update((state) => [
                                                              ...state,
                                                              products![index]
                                                                  .id!
                                                            ]);
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.green),
                                                  ),
                                                  icon: const Icon(Icons.add),
                                                  label: const Text(
                                                      'Добавить в корзину'))
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
                      )
                    : const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
              }),
        ],
      ),
      floatingActionButton: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return FloatingActionButton.extended(
            onPressed: () {
              showItems(context, productIds, products);
            },
            icon: const Icon(Icons.shopping_cart),
            label: Text(productIds.isEmpty ? '' : productIds.length.toString()),
          );
        },
      ),
    );
  }
}
