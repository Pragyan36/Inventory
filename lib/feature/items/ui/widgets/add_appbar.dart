import 'package:flutter/material.dart';
import 'package:inventorymanagement/common/utils/cloudnaryhelper.dart';
import 'package:provider/provider.dart';
import 'package:inventorymanagement/common/constant/color.dart';
import 'package:inventorymanagement/common/constant/assets.dart';
import 'package:inventorymanagement/common/constant/Textstyle.dart';
import 'package:inventorymanagement/feature/items/model/price_model.dart';
import 'package:inventorymanagement/feature/provider/additems_provider.dart';

class AddItemsAppBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool hasChanges;
  final List<PriceItem> priceList;

  const AddItemsAppBar({
    Key? key,
    required this.formKey,
    required this.hasChanges,
    required this.priceList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              Assets.cross,
              color: Colors.white,
              height: 40,
              width: 40,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              if (formKey.currentState!.validate()) {
                final additemsProvider =
                    Provider.of<AdditemsProvider>(context, listen: false);
                if (additemsProvider.imageFile != null) {
                  final url = await CloudinaryHelper.uploadToCloudinary(
                      additemsProvider.imageFile!);
                  if (url != null) {
                    additemsProvider.imageUrl = url;
                    print("✅ Image uploaded: $url");
                  } else {
                    print("❌ Image upload failed");
                    // Optionally show error snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Image upload failed")),
                    );
                    return; // Stop save if image upload fails
                  }
                }
                await additemsProvider.sendItemToDatabase(context, priceList);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: hasChanges ? AppColor.primarycolor : Colors.grey,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text("Save", style: dashboardtextStyle.copyWith()),
            ),
          ),
        ],
      ),
    );
  }
}
