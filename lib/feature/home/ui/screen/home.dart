import 'package:flutter/material.dart';
import 'package:inventorymanagement/feature/home/ui/widgets/homeGrid.dart';
import 'package:inventorymanagement/feature/home/ui/widgets/recentWidegt.dart';
import 'package:inventorymanagement/feature/home/ui/widgets/summary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 70),
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Summary(),
              SizedBox(
                height: 15,
              ),
              HomeGrid(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10),
                child: Text("Recent Items",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
              RecentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
