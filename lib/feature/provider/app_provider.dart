import 'package:inventorymanagement/feature/provider/menu_provider.dart';
import 'package:inventorymanagement/feature/provider/additems_provider.dart';
import 'package:inventorymanagement/feature/provider/authstate.dart';
import 'package:inventorymanagement/feature/provider/items_provider.dart';
import 'package:inventorymanagement/feature/provider/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProvider() {
  return [
    ChangeNotifierProvider(create: (context) => Authstate()),
    ChangeNotifierProvider(create: (context) => Poststate()),
    ChangeNotifierProvider(create: (context) => ItemsProvider()),
    ChangeNotifierProvider(create: (context) => AdditemsProvider()),
    ChangeNotifierProvider(create: (context) => Menuprovider()),
  ];
}
