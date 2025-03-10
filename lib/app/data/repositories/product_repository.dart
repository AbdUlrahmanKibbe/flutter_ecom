import '../data_source/remote_data_source.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository_interface.dart';

class ProductRepository implements ProductRepositoryInterface {
  final RemoteDataSource remoteDataSource;

  ProductRepository(this.remoteDataSource);

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final data = await remoteDataSource.fetchProductsByCategory(category);
    return data.map((e) => Product.fromJson(e)).toList();
  }
}
