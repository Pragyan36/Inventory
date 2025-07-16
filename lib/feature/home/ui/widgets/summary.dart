import 'package:flutter/material.dart';
import 'package:inventorymanagement/common/constant/Textstyle.dart';
import 'package:inventorymanagement/common/constant/assets.dart';

class Summary extends StatelessWidget {
  const Summary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, top: 10, right: 20),
        child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xff1B2632)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.collection,
                      height: 12,
                      width: 12,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: Text(
                  "Inventory Summary",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40, bottom: 10, top: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Items",
                          style: dashboardStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("1", style: dashboardtextStyle)
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "Total Unit",
                          style: dashboardStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("1", style: dashboardtextStyle)
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "Total Price",
                          style: dashboardStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Rs.1",
                          style: dashboardtextStyle,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
