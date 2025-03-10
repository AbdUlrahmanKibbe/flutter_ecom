import '../entities/product.dart';

abstract class ProductRepositoryInterface {
  Future<List<Product>> getProductsByCategory(String category);
}
