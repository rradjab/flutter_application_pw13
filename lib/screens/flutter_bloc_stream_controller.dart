import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pw13/api/get_products.dart';
import 'package:flutter_application_pw13/dialogs/cart_items.dart';
import 'package:flutter_application_pw13/main.dart';
import 'package:flutter_application_pw13/model/products.dart';

class ECommerceEvent {
  int element;
  ECommerceEvent({required this.element});
}

class ECommerceBloc {
  List<int> list = [];
  final _streamController = StreamController<List<int>>();

  Stream<List<int>> get myStream => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  void processEvent(ECommerceEvent action) async {
    list = [...list, action.element];
    _streamController.sink.add(list);
  }
}

class BlocStreamExample extends StatefulWidget {
  const BlocStreamExample({super.key});

  @override
  State<BlocStreamExample> createState() => _BlocStreamExampleState();
}

class _BlocStreamExampleState extends State<BlocStreamExample> {
  late final ECommerceBloc eCommerceBloc;
  @override
  void initState() {
    super.initState();
    eCommerceBloc = ECommerceBloc();
  }

  @override
  void dispose() {
    eCommerceBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
                                        eCommerceBloc.processEvent(
                                            ECommerceEvent(
                                                element: products![index].id!));
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
      floatingActionButton: StreamBuilder<List<int>>(
          stream: eCommerceBloc.myStream,
          builder: (context, snapshot) {
            return FloatingActionButton.extended(
              onPressed: () {
                showItems(context, snapshot.data!, products);
              },
              icon: const Icon(Icons.shopping_cart),
              label: snapshot.hasData
                  ? Text(snapshot.data!.isEmpty
                      ? ''
                      : snapshot.data!.length.toString())
                  : const Text(''),
            );
          }),
    );
  }
}
