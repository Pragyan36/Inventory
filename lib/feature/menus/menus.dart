// // import 'package:flutter/material.dart';
// // import 'package:inventorymanagement/feature/items/model/additems_model.dart';
// // import 'package:inventorymanagement/feature/provider/items_provider.dart';
// // import 'package:inventorymanagement/common/constant/assets.dart';
// // import 'package:inventorymanagement/feature/items/ui/widgets/listWidgets.dart'; // Assuming you have this
// // import 'package:inventorymanagement/feature/items/ui/widgets/showItemOptions.dart';
// // import 'package:provider/provider.dart';

// // class Menus extends StatefulWidget {
// //   const Menus({super.key});

// //   @override
// //   State<Menus> createState() => _MenusState();
// // }

// // class _MenusState extends State<Menus> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final itemsProvider = Provider.of<ItemsProvider>(context, listen: false);

// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         elevation: 0,
// //         title: const Text(
// //           "Menus",
// //           style: TextStyle(
// //               color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
// //         ),
// //       ),
// //       body: FutureBuilder<List<ItemModel>>(
// //         future: itemsProvider.fetchItems(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text("Error: ${snapshot.error}"));
// //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return const Center(child: Text("No menu items found"));
// //           } else {
// //             // Filter only menu items
// //             final menuItems =
// //                 snapshot.data!.where((item) => item.isMenus).toList();

// //             return ListView.builder(
// //               itemCount: menuItems.length,
// //               itemBuilder: (context, index) {
// //                 final item = menuItems[index];
// //                 return Container(
// //                   height: 70,
// //                   width: 70,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(12),
// //                     color: Colors.white,
// //                   ),
// //                   child: Text("$item.name"),
// //                 );
// //                 // return ItemList(
// //                 //   ontap: () => showItemOptions(context, {
// //                 //     'name': item.name,
// //                 //     'quantity': item.quantity,
// //                 //     'isActive': item.isMenus,
// //                 //     'image': item.imagePath ?? Assets.momo,
// //                 //   }),
// //                 //   item: {
// //                 //     "id": item.id,
// //                 //     'sku': item.sku,
// //                 //     'name': item.name,
// //                 //     'quantity': item.quantity,
// //                 //     'image': item.imagePath ?? Assets.momo,
// //                 //   },
// //                 // );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:inventorymanagement/feature/items/model/additems_model.dart';
// import 'package:inventorymanagement/feature/provider/items_provider.dart';
// import 'package:inventorymanagement/common/constant/assets.dart';
// import 'package:provider/provider.dart';

// class Menus extends StatefulWidget {
//   const Menus({super.key});

//   @override
//   State<Menus> createState() => _MenusState();
// }

// class _MenusState extends State<Menus> {
//   @override
//   Widget build(BuildContext context) {
//     final itemsProvider = Provider.of<ItemsProvider>(context, listen: false);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: const Text(
//           "Menus",
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
//         ),
//       ),
//       body: FutureBuilder<List<ItemModel>>(
//         future: itemsProvider.fetchItems(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No menu items found"));
//           } else {
//             // Filter only menu items
//             final menuItems =
//                 snapshot.data!.where((item) => item.isMenus == true).toList();

//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//               child: GridView.builder(
//                 itemCount: menuItems.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, // Number of items per row
//                   crossAxisSpacing: 40,
//                   mainAxisSpacing: 40,
//                   childAspectRatio: 1 / 1, // Adjust the item size
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = menuItems[index];
//                   return Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.white,
//                     ),
//                     child: Center(
//                       child: Text(
//                         item.name,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.black),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:inventorymanagement/feature/items/model/additems_model.dart';
import 'package:inventorymanagement/feature/provider/items_provider.dart';
import 'package:provider/provider.dart';

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  // Store selected color per item ID
  final Map<String, Color> _selectedColors = {};

  // Show color picker bottom sheet
  void _showColorPicker(BuildContext context, String itemId) {
    Color pickerColor = _selectedColors[itemId] ?? Colors.white;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              // or use ColorPicker for HSV/RGB sliders
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Select'),
              onPressed: () {
                setState(() {
                  _selectedColors[itemId] = pickerColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<ItemsProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Menus",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
        ),
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: itemsProvider.fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No menu items found"));
          } else {
            final menuItems =
                snapshot.data!.where((item) => item.isMenus == true).toList();

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final boxColor = _selectedColors[item.id] ?? Colors.white;

                  return GestureDetector(
                    onTap: () {
                      _showColorPicker(context, item.id!);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: boxColor,
                      ),
                      child: Center(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: boxColor.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
