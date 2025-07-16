import 'package:flutter/material.dart';
import 'package:inventorymanagement/common/constant/assets.dart';
import 'package:inventorymanagement/common/utils/animationpage.dart';
import 'package:inventorymanagement/feature/items/model/additems_model.dart';
import 'package:inventorymanagement/feature/items/ui/screen/addItem.dart';
import 'package:inventorymanagement/feature/items/ui/widgets/Appbar.dart';
import 'package:inventorymanagement/common/filterbutton.dart';
import 'package:inventorymanagement/feature/items/ui/widgets/filter.dart';
import 'package:inventorymanagement/feature/items/ui/widgets/showItemOptions.dart';
import 'package:inventorymanagement/feature/items/ui/widgets/listWidgets.dart';
import 'package:inventorymanagement/feature/provider/items_provider.dart';
import 'package:provider/provider.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    int _extractNumericUnit(String? unit) {
      return int.tryParse(unit ?? '') ?? 0;
    }

    final filterProvider = Provider.of<ItemsProvider>(context);

    return Consumer<ItemsProvider>(builder: (
      context,
      itemstate,
      _,
    ) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ItemsAppbar(),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(
                      label: itemstate.selectedFilter,
                      onPressed: () =>
                          ItemBottomSheets.showFilterBottomSheet(context),
                      imagePath: Assets.filter),
                  FilterButton(
                    label: itemstate.selectedSort,
                    imagePath: Assets.filter,
                    onPressed: () =>
                        ItemBottomSheets.showSortBottomSheet(context),
                  ),
                ],
              ),

              /// Item List
              Expanded(
                child: FutureBuilder<List<ItemModel>>(
                  future: itemstate.fetchItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No items found"));
                    } else {
                      List<ItemModel> items = snapshot.data!;

                      // Apply filter
                      List<ItemModel> filteredItems = items.where((item) {
                        switch (filterProvider.selectedFilter) {
                          case 'Menus':
                            return item.isMenus == true;
                          case 'Not in Menu':
                            return item.isMenus == false;
                          case 'Returnable':
                            return item.isReturnable == true;
                          case 'Not Returnable':
                            return item.isReturnable == false;
                          case 'Active Items':
                            return item.isActive == true;
                          case 'Inactive Items':
                            return item.isActive == false;
                          case 'All Items':
                          default:
                            return true;
                        }
                      }).toList();

                      // Sort items
                      if (itemstate.selectedSort == 'Created Time') {
                        filteredItems = filteredItems
                            .where((item) =>
                                item.createdAt != null &&
                                item.createdAt!.isNotEmpty)
                            .toList()
                          ..sort((a, b) => DateTime.parse(b.createdAt!)
                              .compareTo(DateTime.parse(
                                  a.createdAt!))); // Newest first
                      } else if (itemstate.selectedSort == 'Name') {
                        filteredItems.sort((a, b) => (a.name ?? '')
                            .toLowerCase()
                            .compareTo((b.name ?? '').toLowerCase())); // A–Z
                      } else if (itemstate.selectedSort == 'SKU') {
                        filteredItems.sort((a, b) {
                          final aNum = int.tryParse((a.sku ?? '')
                                  .replaceAll(RegExp(r'[^0-9]'), '')) ??
                              0;
                          final bNum = int.tryParse((b.sku ?? '')
                                  .replaceAll(RegExp(r'[^0-9]'), '')) ??
                              0;
                          return aNum.compareTo(bNum); // Smallest SKU first
                        });
                      } else if (itemstate.selectedSort == 'Unit') {
                        filteredItems.sort((a, b) {
                          final aUnit = _extractNumericUnit(a.unit);
                          final bUnit = _extractNumericUnit(b.unit);
                          return bUnit
                              .compareTo(aUnit); // Highest unit number first
                        });
                      }

                      return ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];

                          return ItemList(
                            ontap: () => showItemOptions(context, {
                              'name': item.name,
                              'quantity': item.quantity,
                              'isActive': item.isMenus,
                              'image':
                                  item.imagePath ?? Assets.momo, // fallback
                            }),
                            item: {
                              "id": item.id,
                              'sku': item.sku,
                              'name': item.name,
                              'quantity': item.quantity,
                              'image': item.imagePath ?? Assets.momo,
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff1B2632),
          onPressed: () {
            Navigator.of(context).push(createSlideFromBottomRoute(
              AddItem(),
            ));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
    });
  }
}
