import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventorymanagement/feature/items/model/additems_model.dart';

class ItemsProvider extends ChangeNotifier {
  String selectedFilter = 'All Items';
  String selectedSort = 'Created Time';
  void setFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void setSort(String sort) {
    selectedSort = sort;
    notifyListeners();
  }

  Future<List<ItemModel>> fetchItems() async {
    final snapshot = await FirebaseFirestore.instance.collection('items').get();

    return snapshot.docs.map((doc) {
      return ItemModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}
