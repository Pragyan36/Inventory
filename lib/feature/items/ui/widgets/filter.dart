import 'package:flutter/material.dart';
import 'package:inventorymanagement/feature/provider/items_provider.dart';
import 'package:provider/provider.dart';
// import 'package:inventorymanagement/provider/items_provider.dart'; // adjust import as needed

class ItemBottomSheets {
  static void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xff1B2632),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (_) {
        return Consumer<ItemsProvider>(
          builder: (context, provider, _) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              children: [
                const Text(
                  "Filter By",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                _buildFilterTile(context, provider, 'All Items'),
                _buildFilterTile(context, provider, 'Active Items'),
                _buildFilterTile(context, provider, 'Inactive Items'),
                _buildFilterTile(context, provider, 'Menus'),
                _buildFilterTile(context, provider, 'Not in Menu'),
                _buildFilterTile(context, provider, 'Returnable'),
                _buildFilterTile(context, provider, 'Not Returnable'),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildFilterTile(
      BuildContext context, ItemsProvider provider, String label) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: provider.selectedFilter == label
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        provider.setFilter(label);
        Navigator.pop(context);
      },
    );
  }

  static void showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xff1B2632),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (_) {
        return Consumer<ItemsProvider>(
          builder: (context, provider, _) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              children: [
                const Text("Sort By",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 10),
                _buildSortTile(context, provider, 'Created Time'),
                _buildSortTile(context, provider, 'Name'),
                _buildSortTile(context, provider, 'SKU'),
                _buildSortTile(context, provider, 'Unit'),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildSortTile(
      BuildContext context, ItemsProvider provider, String label) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: provider.selectedSort == label
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        provider.setSort(label);
        Navigator.pop(context);
      },
    );
  }
}
