import 'package:flutter/material.dart';
import 'package:inventorymanagement/common/constant/assets.dart';
import 'package:inventorymanagement/feature/home/ui/widgets/hompageContainer.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              // First Container
              DashboardContainer(
                iconPath: Assets.stockout,
                title: "Menu",
                subtitle: "Access and manage your product list",
              ),

              SizedBox(width: 10),
              DashboardContainer(
                iconPath: Assets.transaction,
                title: "Transaction",
                subtitle: "Track stock purchases and sales history",
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              // First Container
              DashboardContainer(
                iconPath: Assets.expiredate,
                title: "Expired items",
                subtitle: "View products that have passed their expiry date",
              ),

              SizedBox(width: 10),
              DashboardContainer(
                iconPath: Assets.stockout,
                title: "Out Of Stock",
                subtitle: "View all stock item that low inventory",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
