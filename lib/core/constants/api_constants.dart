
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://newsapi.org/v2';

  static String get apiKey =>
      (dotenv.maybeGet('NEWS_API_KEY') ?? '').trim();

  static const String country = 'us';
  static const String language = 'id';

  static const int pageSize = 10;

  static const Duration timeout = Duration(seconds: 15);
}
