import 'package:flutter_application_api2/app/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

class ShowProductBinding extends Bindings {
  final String category;
  ShowProductBinding(this.category);

  @override
  void dependencies() {
    // استخدم Get.lazyPut لتحميل الـ ProductController فقط عند الحاجة
    Get.lazyPut<ProductController>(() => ProductController(category));
  }
}
