import 'package:flutter/material.dart';
import 'package:inventorymanagement/feature/home/ui/widgets/RecentboxContainer.dart';

class RecentWidget extends StatelessWidget {
  const RecentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
      child: SizedBox(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(10, (index) {
              return RecentContainer(
                id: 'ID001',
                name: 'Chowmein',
                quantity: '100 units',
                imagePath: 'assets/images/item1.png',
              );
            }),
          ),
        ),
      ),
    );
  }
}
