import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/presentation/pages/home_page.dart';
import 'app/presentation/bindings/home_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialBinding: HomeBinding(), // إضافة الربط هنا
      home: HomePage(),
    );
  }
}
