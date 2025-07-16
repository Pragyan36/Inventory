import 'package:flutter/material.dart';
import 'package:inventorymanagement/feature/provider/menu_provider.dart';
import 'package:provider/provider.dart';

class FoodIconList extends StatelessWidget {
  const FoodIconList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Menuprovider>(builder: (
      context,
      foodicon,
      _,
    ) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Food Icons",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: foodicon.foodIcons.length,
          itemBuilder: (context, index) {
            final imagePath = foodicon.foodIcons[index];
            final label = imagePath
                .split('/')
                .last
                .replaceAll('--Streamline-Plump.png', '')
                .replaceAll('-', ' ');

            return Column(
              children: [
                ListTile(
                  leading: Image.asset(
                    imagePath,
                    width: 25,
                    height: 25,
                    color: Colors.white,
                  ),
                  title: Text(
                    label,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Divider(
                  color: Colors.white24,
                  thickness: 1,
                  height: 0,
                  endIndent: 12,
                  indent: 12,
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
