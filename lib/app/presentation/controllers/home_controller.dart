import 'package:get/get.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../domain/entities/product.dart';

class HomeController extends GetxController {
  var categories = <String>[].obs;
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs; // قائمة المنتجات المفلترة
  var isLoading = true.obs;

  final RemoteDataSource _dataSource = RemoteDataSource();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchAllProducts();
  }

  void fetchCategories() async {
    try {
      isLoading.value = true;
      var fetchedCategories = await _dataSource.fetchCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void fetchAllProducts() async {
    try {
      isLoading.value = true;
      var fetchedProducts = await _dataSource.fetchAllProducts();
      products.assignAll(fetchedProducts.map((e) => Product.fromJson(e)).toList());
      filteredProducts.assignAll(products); // تعيين جميع المنتجات في البداية
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch products: $e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // تعديل دالة البحث لتكون عبر السيرفر
  void searchProducts(String query) async {
    if (query.isEmpty) {
      filteredProducts.assignAll(products); // إعادة جميع المنتجات عند مسح البحث
    } else {
      try {
        isLoading.value = true;
        var fetchedProducts = await _dataSource.searchProducts(query);
        filteredProducts.assignAll(fetchedProducts.map((e) => Product.fromJson(e)).toList());
      } catch (e) {
        Get.snackbar("Error", "Failed to search products: $e", snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    }
  }
}
