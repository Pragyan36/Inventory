import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventorymanagement/feature/items/model/additems_model.dart';
import 'package:inventorymanagement/feature/items/model/price_model.dart';
import 'package:inventorymanagement/feature/items/ui/screen/items.dart';

class AdditemsProvider extends ChangeNotifier {
  String capitalizeWords(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController wholesalepriceController =
      TextEditingController();
  final TextEditingController sellingpriceController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController expireDateController = TextEditingController();

  String itemType = 'Good';
  String selectedCategory = 'Food';
  bool isReturnable = false;
  bool isMenus = false;
  bool isActive = false;
  String? imageUrl;

  void setImageUrl(String url) {
    imageUrl = url;
    notifyListeners();
  }

  File? imageFile; // Add this

  void setImageFile(File file) {
    imageFile = file;
    notifyListeners();
  }

  Future<void> sendItemToDatabase(
      BuildContext context, List<PriceItem> priceList) async {
    final item = ItemModel(
      name: capitalizeWords(nameController.text.trim()),
      quantity: capitalizeWords(quantityController.text.trim()),
      wholesalePrice: capitalizeWords(wholesalepriceController.text.trim()),
      unit: capitalizeWords(unitController.text.trim()),
      expireDate: capitalizeWords(expireDateController.text.trim()),
      itemType: capitalizeWords(itemType),
      category: capitalizeWords(selectedCategory),
      isReturnable: isReturnable,
      isActive: isActive,
      isMenus: isMenus,
      priceList: priceList,
      createdBy: "admin",
      createdAt: DateTime.now().toIso8601String(),
      imagePath: imageUrl,
    );

    try {
      await FirebaseFirestore.instance.collection('items').add(item.toJson());
      debugPrint("Item added to Firestore successfully!");

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Items()),
        );
      }
    } catch (e) {
      debugPrint("Error adding item to Firestore: $e");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save item: $e")),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    wholesalepriceController.dispose();
    sellingpriceController.dispose();
    unitController.dispose();
    expireDateController.dispose();
    super.dispose();
  }
}
