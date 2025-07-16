import 'package:flutter/material.dart';
import 'package:inventorymanagement/common/constant/Textstyle.dart';
import 'package:inventorymanagement/common/constant/assets.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.item,
    required this.ontap,
  });

  final Map<String, dynamic> item;

  final VoidCallback ontap; // <-- fix added here

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xff1B2632),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item['image'] ??
                    Assets
                        .momo, // fallback to local asset path only if URL is null
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if image URL is invalid or fails to load
                  return Image.asset(
                    Assets.momo,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item['name'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Image.asset(
                        Assets.dots,
                        height: 20,
                        width: 15,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${item['sku'] ?? '0'} ",
                    style: dashboardStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${item['quantity'] ?? '0'} Units",
                    style: dashboardStyle,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
