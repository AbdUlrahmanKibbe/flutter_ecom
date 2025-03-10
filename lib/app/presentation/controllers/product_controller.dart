import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/data_source/remote_data_source.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  final String category;

  ProductController(this.category);

  final ProductRepository _repository = ProductRepository(RemoteDataSource());

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      var fetchedProducts = await _repository.getProductsByCategory(category);
      products.assignAll(fetchedProducts);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch products: $e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
