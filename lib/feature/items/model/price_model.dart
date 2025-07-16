class PriceItem {
  final String name;
  final String multiplier;
  final String price;

  PriceItem(
      {required this.name, required this.multiplier, required this.price});

  factory PriceItem.fromJson(Map<String, dynamic> json) => PriceItem(
        name: json['name'] ?? '',
        multiplier: json['multiplier'] ?? '',
        price: json['price'] ?? '',
      );
  Map<String, dynamic> toJson() => {
        'name': name,
        'multiplier': multiplier,
        'price': price,
      };
}

List<PriceItem> priceList = [];
