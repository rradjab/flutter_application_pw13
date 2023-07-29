import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_application_pw13/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_pw13/dialogs/cart_items.dart';
import 'package:flutter_application_pw13/business/flutter_redux/flutter_redux.dart'
    as rdx;

class ReduxExample extends StatelessWidget {
  ReduxExample({super.key});
  final Store<rdx.AppState> store = Store<rdx.AppState>(
    rdx.reducer,
    initialState: rdx.AppState([]),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Scaffold(
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
                                    StoreConnector<rdx.AppState, VoidCallback>(
                                      converter: (store) {
                                        return () => store.dispatch(rdx.Action(
                                            rdx.ActionType.addProduct,
                                            element: products![index].id!));
                                      },
                                      builder: (context, callback) {
                                        return ElevatedButton.icon(
                                          onPressed: callback,
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                          ),
                                          icon: const Icon(Icons.add),
                                          label:
                                              const Text('Добавить в корзину'),
                                        );
                                      },
                                    ),
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
        floatingActionButton: StoreConnector<rdx.AppState, List<int>>(
          converter: (store) => store.state.productsList,
          builder: (context, productsList) {
            return FloatingActionButton.extended(
                onPressed: () {
                  showItems(context, productsList, products);
                },
                icon: const Icon(Icons.shopping_cart),
                label: Text(productsList.isEmpty
                    ? ''
                    : productsList.length.toString()));
          },
        ),
      ),
    );
  }
}
