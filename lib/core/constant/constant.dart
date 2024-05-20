import 'package:flutter_dotenv/flutter_dotenv.dart';

const String newsAPIBaseUrl = "https://newsapi.org/v2";
String newsAPIKey = dotenv.env["NEWS_API_KEY"] ?? "";
const String countryQuery = "us";
const String categoryQuery = "general";
