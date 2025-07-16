import 'package:flutter/material.dart';

void showAddSellingPriceDialog(
  BuildContext context,
  void Function(String name, String multiplier, String price) onAdd,
) {
  final nameController = TextEditingController();
  final multiplierController = TextEditingController();
  final priceController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Price',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: multiplierController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(hintText: 'Ingredients Multiplier'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Price'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              onAdd(
                nameController.text,
                multiplierController.text,
                priceController.text,
              );
              Navigator.of(context).pop();
            },
            child: const Text('Add', style: TextStyle(color: Colors.green)),
          ),
        ],
      );
    },
  );
}
