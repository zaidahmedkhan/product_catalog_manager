import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog_manager/models/product.dart';

void main() {
  group('Product', () {
    test('fromJson parses crudcrud response', () {
      final product = Product.fromJson({
        '_id': '64f3a1b2c7e8d9001a2b3c4d',
        'name': 'Architect Chronograph',
        'price': 349.00,
      });

      expect(product.id, '64f3a1b2c7e8d9001a2b3c4d');
      expect(product.name, 'Architect Chronograph');
      expect(product.price, 349.0);
    });

    test('toJson excludes _id for POST/PUT', () {
      final product = Product(
        id: '64f3a1b2c7e8d9001a2b3c4d',
        name: 'Test Product',
        price: 99.99,
      );

      expect(product.toJson(), {
        'name': 'Test Product',
        'price': 99.99,
      });
      expect(product.toJson().containsKey('_id'), false);
      expect(product.toJson().containsKey('id'), false);
    });

    test('new product has null id before API assigns it', () {
      final product = Product(name: 'New Item', price: 10.0);
      expect(product.id, isNull);
    });
  });
}
