import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteDataSource {
  final String baseUrl;
  final http.Client client;

  RemoteDataSource({this.baseUrl = 'https://dummyjson.com/products', http.Client? client})
      : client = client ?? http.Client();

  // إضافة دالة البحث
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/search?q=$query')).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('products')) {
          return List<Map<String, dynamic>>.from(data['products']);
        }
      }
      throw Exception('Failed to search products');
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }

  // باقي الدوال كما هي
  Future<List<String>> fetchCategories() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/category-list')).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((category) => category.toString()).toList();
      }
      throw Exception('Failed to load categories');
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // جلب جميع المنتجات
  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl')).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('products')) {
          return List<Map<String, dynamic>>.from(data['products']);
        }
      }
      throw Exception('Failed to load products');
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
  
  // جلب المنتجات حسب الفئة
  Future<List<Map<String, dynamic>>> fetchProductsByCategory(String category) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/category/$category')).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('products')) {
          return List<Map<String, dynamic>>.from(data['products']);
        }
      }
      throw Exception('Failed to load products for category $category');
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }
}
