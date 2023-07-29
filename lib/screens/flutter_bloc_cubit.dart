import 'package:flutter/material.dart';
import 'package:flutter_application_pw13/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_pw13/dialogs/cart_items.dart';

List<int> list = [];

class ECommerceBloc extends Cubit<ECommerceState> {
  ECommerceBloc() : super(ECommerceState(list: []));

  void addProduct(int element) {
    list = [...list, element];
    emit(ECommerceState(list: list));
  }
}

class ECommerceState {
  List<int> list;
  ECommerceState({required this.list});
}

class BlocCubitExample extends StatelessWidget {
  BlocCubitExample({super.key});

  final eCommerceBloc = ECommerceBloc();

  @override
  Widget build(context) {
    return BlocBuilder<ECommerceBloc, ECommerceState>(
      bloc: eCommerceBloc,
      builder: (context, state) {
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
                                  Text(
                                      'Category: ${products?[index].category}'),
                                  Text('Stock: ${products?[index].stock}'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Price: ${products?[index].price}\$'),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            eCommerceBloc.addProduct(
                                                products![index].id!);
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                          ),
                                          icon: const Icon(Icons.add),
                                          label:
                                              const Text('Добавить в корзину'))
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showItems(context, state.list, products);
            },
            icon: const Icon(Icons.shopping_cart),
            label: Text(state.list.isEmpty ? '' : state.list.length.toString()),
          ),
        );
      },
    );
  }
}
