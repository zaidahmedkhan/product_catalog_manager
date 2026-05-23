import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String _crudcrudHost = 'https://crudcrud.com/api';

  static String get apiId {
    final id = dotenv.env['CRUDCRUD_API_ID'];
    if (id == null || id.trim().isEmpty) {
      throw Exception('CRUDCRUD_API_ID not set in .env');
    }
    return id.trim();
  }

  static String get baseUrl => '$_crudcrudHost/$apiId';

  static String get productsEndpoint => '$baseUrl/products';
}
