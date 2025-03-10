import 'package:flutter/material.dart';
import 'package:flutter_application_api2/app/presentation/pages/profuct.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'show_product_page.dart';
import 'package:flutter_application_api2/app/presentation/bindings/product_binding.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          // أيقونة البحث
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // يمكنك إضافة أي عملية عند الضغط على الأيقونة، مثل فتح حقل البحث.
            },
          ),
          // أيقونة الفئات
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // يمكنك إضافة عملية لتصفية المنتجات أو فتح قائمة الفئات
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // حقل البحث مع أيقونة
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
              onChanged: (query) {
                // البحث في المنتجات من السيرفر
                controller.searchProducts(query);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) return Center(child: CircularProgressIndicator());

              return ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  // عرض الفئات
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Categories",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ShowProductPage(category: controller.categories[index]),
                              binding: ShowProductBinding(controller.categories[index]),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.category, size: 35, color: Colors.white),
                                SizedBox(height: 5),
                                Text(
                                  controller.categories[index],
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // عرض جميع المنتجات
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("All Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          // التنقل إلى صفحة تفاصيل المنتج
                          Get.to(() => ProductDetailPage(product: product));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                  child: Image.network(
                                    product.image,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    Text(
                                      "\$${product.price}",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
