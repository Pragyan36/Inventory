import 'dart:math';

import 'package:inventorymanagement/feature/items/model/price_model.dart';

class ItemModel {
  final String? id;
  final String? sku;
  final String name;
  final String quantity;
  final String wholesalePrice;
  final String unit;
  final String expireDate;
  final String itemType;
  final String category;
  final bool isReturnable;
  final bool isActive;
  final bool isMenus;
  final String? imagePath;
  final String? createdBy;
  final String? createdAt;
  final List<PriceItem> priceList;

  ItemModel({
    String? sku,
    this.id,
    required this.name,
    required this.quantity,
    required this.wholesalePrice,
    required this.unit,
    required this.expireDate,
    required this.itemType,
    required this.category,
    required this.isReturnable,
    required this.isActive,
    required this.isMenus,
    required this.priceList,
    this.createdBy,
    this.createdAt,
    this.imagePath,
  }) : sku = sku ?? _generateSKU();

  static String _generateSKU() {
    final rand = Random();
    final number = 10 + rand.nextInt(90); // 2-digit number (10–99)
    final millis = DateTime.now().millisecond; // 0–999
    return 'SKU-${number}${millis % 100}'; // e.g. SKU-4512
  }

  toJson() => {
        'sku': sku,
        'name': name,
        'quantity': quantity,
        'wholesalePrice': wholesalePrice,
        'unit': unit,
        'expireDate': expireDate,
        'itemType': itemType,
        'category': category,
        'isReturnable': isReturnable,
        'isActive': isActive,
        'isMenus': isMenus,
        'imagePath': imagePath,
        'createdBy': createdBy,
        'createdAt': createdAt,
        'priceList': priceList.map((e) => e.toJson()).toList(),
      };

  factory ItemModel.fromJson(Map<String, dynamic> json, String docId) {
    return ItemModel(
      id: docId,
      sku: json['sku'] ?? "",
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? '',
      wholesalePrice: json['wholesalePrice'] ?? '',
      unit: json['unit'] ?? '',
      expireDate: json['expireDate'] ?? '',
      itemType: json['itemType'] ?? '',
      category: json['category'] ?? '',
      isReturnable: json['isReturnable'] ?? false,
      isMenus: json['isMenus'] ?? false,
      isActive: json['isActive'] ?? false,
      imagePath: json['imagePath'],
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] ?? '',
      priceList: (json['priceList'] as List<dynamic>?)
              ?.map((e) => PriceItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}
