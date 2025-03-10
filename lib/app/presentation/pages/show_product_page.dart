import 'package:flutter/material.dart';
import 'package:flutter_application_api2/app/presentation/pages/profuct.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class ShowProductPage extends StatelessWidget {
  final String category;
  ShowProductPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(title: Text(category, style: TextStyle(fontWeight: FontWeight.bold))),
      body: Obx(() {
        if (controller.isLoading.value) return Center(child: CircularProgressIndicator());

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return GestureDetector(
              onTap: () {
                // التنقل إلى صفحة تفاصيل المنتج
                Get.to(() => ProductDetailPage(product: product));
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(product.image, width: double.infinity, height: 200, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text("\$${product.price}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
