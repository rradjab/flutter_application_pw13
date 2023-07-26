import 'package:flutter/material.dart';
import 'package:flutter_application_pw13/model/products.dart';

void showItems(BuildContext context, List<int> items, List<Products>? prod) {
  debugPrint(items.toString());
  Map<int, int> count = {};
  for (var i in items) {
    count[i] = (count[i] ?? 0) + 1;
  }
  num totalPrice = 0;

  for (var i in items.toSet()) {
    totalPrice += prod!
            .where(
              (element) => element.id == i,
            )
            .toList()[0]
            .price! *
        count[i]!;
  }

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SizedBox(
        height: 300.0,
        width: 300.0,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.toSet().length,
                itemBuilder: (context, index) {
                  Products product = prod!
                      .where(
                        (element) =>
                            element.id == items.toSet().elementAt(index),
                      )
                      .toList()[0];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.title.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                              'Price: ${product.price}\$, (x${count[items.toSet().elementAt(index)]})'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Text('Total Price: $totalPrice\$'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('Buy'),
        ),
      ],
    ),
  );
}
