import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:inventorymanagement/common/constant/Textstyle.dart';
import 'package:inventorymanagement/common/constant/assets.dart';
import 'package:inventorymanagement/common/utils/cloudnaryhelper.dart';
import 'package:inventorymanagement/common/utils/textfield.dart';
import 'package:inventorymanagement/feature/items/model/price_model.dart';
import 'package:inventorymanagement/feature/items/ui/widgets/add_appbar.dart';
import 'package:inventorymanagement/feature/items/ui/widgets/selling_widget.dart';
import 'package:inventorymanagement/feature/provider/additems_provider.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();

  double totalValuation = 0.0;
  bool hasChanges = false;
  void _markAsChanged() {
    if (!hasChanges) {
      setState(() {
        hasChanges = true;
      });
    }
  }

  late AdditemsProvider additemsProvider;
  @override
  void initState() {
    super.initState();
  }

  File? _imageFile;
  String? _uploadedImageUrl;
  bool _isPickingImage = false;

  // Future<void> _pickImageFromGallery() async {
  //   final file = await CloudinaryHelper.pickImageFromGallery();
  //   if (file != null) {
  //     setState(() {
  //       _imageFile = file;
  //     });

  //     final url = await CloudinaryHelper.uploadToCloudinary(file);
  //     if (url != null) {
  //       setState(() {
  //         _uploadedImageUrl = url;
  //         additemsProvider.imageUrl = url; // Save to provider
  //       });
  //       print("✅ Image uploaded: $_uploadedImageUrl");
  //     } else {
  //       print("❌ Image upload failed");
  //     }
  //   }
  // }
  void pickAndUploadImage() async {
    File? image = await CloudinaryHelper.pickImage(ImageSource.gallery);
    print("this is image::$image");
    if (image != null) {
      setState(() {
        _imageFile = image; // 🖼️ Update preview
      });

      final imageUrl = await CloudinaryHelper.uploadImage(image);
      if (imageUrl != null) {
        setState(() {
          _uploadedImageUrl = imageUrl;
        });

        additemsProvider.imageUrl = imageUrl; // ✅ Save to provider
        print("✅ Uploaded URL: $imageUrl");
      } else {
        print("❌ Upload failed");
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    additemsProvider = Provider.of<AdditemsProvider>(context, listen: false);
    additemsProvider.quantityController.addListener(_calculateTotalValuation);
    additemsProvider.wholesalepriceController
        .addListener(_calculateTotalValuation);
  }

  void _calculateTotalValuation() {
    final additems = Provider.of<AdditemsProvider>(context, listen: false);
    final quantity = double.tryParse(additems.quantityController.text) ?? 0;
    final price = double.tryParse(additems.wholesalepriceController.text) ?? 0;
    setState(() {
      totalValuation = quantity * price;
    });
  }

  final List<String> categories = [
    'Food',
    'Stationery',
    'Electronics',
    'Other'
  ];
  final List<String> types = ['Good', 'Service'];
  @override
  void dispose() {
    additemsProvider.nameController.dispose();
    additemsProvider.quantityController.dispose();
    additemsProvider.wholesalepriceController.dispose();
    additemsProvider.unitController.dispose();
    additemsProvider.expireDateController.dispose();
    super.dispose();
  }

  void _pickExpireDate() async {
    final additems = Provider.of<AdditemsProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // dark theme for date picker
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        additems.expireDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdditemsProvider>(builder: (
      context,
      additemstate,
      _,
    ) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              AddItemsAppBar(
                formKey: _formKey,
                hasChanges: hasChanges,
                priceList: priceList,
              ),

              /// Form
              AddItemForm(additemstate, context),
            ],
          ),
        ),
      );
    });
  }

  Expanded AddItemForm(AdditemsProvider additemstate, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: DottedBorder(
                  color: Colors.white38,
                  strokeWidth: 1.5,
                  dashPattern: [6, 3], // [dash length, space length]
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.white12,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: pickAndUploadImage,
                      child: _imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _imageFile!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 120,
                              color: Colors.white12,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.white54,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              buildLabeledField(
                label: "Item Name",
                controller: additemstate.nameController,
                validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                imagePath: Assets.food,
                onChanged: (_) => _markAsChanged(),
              ),
              const SizedBox(height: 20),

              buildLabeledField(
                isNumber: true,
                label: "Quantity",
                controller: additemstate.quantityController,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter quantity' : null,
                onChanged: (_) {
                  _calculateTotalValuation();
                  _markAsChanged();
                },
                imagePath: Assets.box,
              ),
              const SizedBox(height: 20),

              buildLabeledField(
                label: " Wholesale Price",
                controller: additemstate.wholesalepriceController,
                validator: (v) => v == null || v.isEmpty ? 'Enter price' : null,
                onChanged: (_) {
                  _calculateTotalValuation();
                  _markAsChanged();
                },
                imagePath: Assets.money,
              ),
              const SizedBox(height: 20),
              Text("Total Valuation", style: authTitleStyle),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs ${totalValuation.toStringAsFixed(2)}",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Icon(Icons.calculate_outlined,
                        color: Colors.white70, size: 25),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Type Dropdown
              Text("Type", style: authTitleStyle),
              DropdownButtonFormField<String>(
                value: additemstate.itemType,
                dropdownColor: Colors.grey[900],
                iconEnabledColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
                items: types
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (val) =>
                    setState(() => additemstate.itemType = val!),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selling Price", style: authTitleStyle),
                  const SizedBox(height: 6),

                  GestureDetector(
                    onTap: () {
                      showAddSellingPriceDialog(context,
                          (name, multiplier, price) {
                        setState(() {
                          priceList.add(PriceItem(
                            name: name,
                            multiplier: multiplier,
                            price: price,
                          ));
                          _markAsChanged();
                        });
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            Assets.add,
                            height: 20,
                            width: 20,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Price list
                  ...priceList.asMap().entries.map((entry) {
                    int index = entry.key;
                    PriceItem item = entry.value;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🗑️ Delete button
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.redAccent),
                                onPressed: () {
                                  setState(() {
                                    priceList.removeAt(index);
                                    _markAsChanged();
                                  });
                                },
                              ),

                              // Name + Multiplier
                              Expanded(
                                child: Text(
                                  "${item.name} (${item.multiplier}x)",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),

                              // Price
                              Text(
                                "Rs. ${item.price}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.white24,
                          thickness: 1,
                          height: 0,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  }).toList(),
                ],
              ),
              const SizedBox(height: 20),

              Text("Category", style: authTitleStyle),
              DropdownButtonFormField<String>(
                value: additemstate.selectedCategory,
                dropdownColor: Colors.grey[900],
                iconEnabledColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
                items: categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (val) =>
                    setState(() => additemstate.selectedCategory = val!),
              ),
              const SizedBox(height: 20),

              /// Expire Date
              buildLabeledField(
                label: "Expire Date",
                controller: additemstate.expireDateController,
                validator: (v) => null,
                imagePath: Assets.calendar, // your custom image path
                onSuffixTap: _pickExpireDate,
              ),
              const SizedBox(height: 20),

              /// Returnable Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Returnable Items", style: authTitleStyle),
                  Switch(
                    value: additemstate.isReturnable,
                    onChanged: (val) =>
                        setState(() => additemstate.isReturnable = val),
                    activeColor: Colors.green,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Active Items", style: authTitleStyle),
                  Switch(
                    value: additemstate.isActive,
                    onChanged: (val) =>
                        setState(() => additemstate.isActive = val),
                    activeColor: Colors.green,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Menus", style: authTitleStyle),
                  Switch(
                    value: additemstate.isMenus,
                    onChanged: (val) =>
                        setState(() => additemstate.isMenus = val),
                    activeColor: Colors.green,
                  )
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
