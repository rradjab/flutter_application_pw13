import 'package:flutter/material.dart';
import 'package:flutter_application_pw13/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_pw13/dialogs/cart_items.dart';
import 'package:flutter_application_pw13/business/hooks_riverpod/hooks_riverpod.dart';

class RiverpodHooksExample extends HookConsumerWidget {
  const RiverpodHooksExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productIds = ref.watch(productsIdList);
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
                                        ref
                                            .read(productsIdList.notifier)
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
              childCount: products?.length,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showItems(context, productIds, products);
        },
        icon: const Icon(Icons.shopping_cart),
        label: Text(productIds.isEmpty ? '' : productIds.length.toString()),
      ),
    );
  }
}
