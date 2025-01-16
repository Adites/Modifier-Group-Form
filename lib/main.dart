import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifier_group_form/modifier_group_list.dart';


import 'modifier_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the ModifierController when the app starts
    Get.put(ModifierController());

    return GetMaterialApp(
      title: 'Modifier Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ModifierListScreen(),
    );
  }
}
