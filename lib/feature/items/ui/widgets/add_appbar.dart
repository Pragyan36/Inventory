import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventorymanagement/common/constant/assets.dart';
import 'package:inventorymanagement/common/constant/color.dart';
import 'package:inventorymanagement/common/constant/Textstyle.dart';
import 'package:inventorymanagement/common/utils/cloudnaryhelper.dart';
import 'package:inventorymanagement/feature/items/model/price_model.dart';
import 'package:inventorymanagement/feature/provider/additems_provider.dart';

class AddItemsAppBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool hasChanges;
  final List<PriceItem> priceList;

  const AddItemsAppBar({
    super.key,
    required this.formKey,
    required this.hasChanges,
    required this.priceList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          _buildBackButton(context),
          const Spacer(),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Image.asset(
        Assets.cross,
        color: Colors.white,
        height: 40,
        width: 40,
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final addItemsProvider = context.read<AdditemsProvider>();

        // Validate form
        if (!formKey.currentState!.validate()) return;

        // Show loading while processing
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );

        try {
          // Upload image to Cloudinary
          if (addItemsProvider.imageFile != null) {
            final url =
                await CloudinaryHelper.uploadImage(addItemsProvider.imageFile!);
            if (url == null) {
              Navigator.pop(context); // Dismiss loading
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("❌ Image upload failed")),
              );
              return;
            }
            addItemsProvider.imageUrl = url;
          }

          // Push item data (with imageUrl) to Firebase
          await addItemsProvider.sendItemToDatabase(context, priceList);

          // Success feedback
          Navigator.pop(context); // Dismiss loading
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Item saved successfully")),
          );
        } catch (e) {
          Navigator.pop(context); // Dismiss loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ Failed to save item: $e")),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: hasChanges ? AppColor.primarycolor : Colors.grey,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Text(
          "Save",
          style: dashboardtextStyle.copyWith(),
        ),
      ),
    );
  }
}
