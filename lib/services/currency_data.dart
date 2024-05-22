// lib/currency_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/currency_model.dart';
import 'package:news_app/services/api_key.dart';

const List<String> desiredCurrencies = [
  "USD",
  "EUR",
  "GBP",
  "JPY",
  "AUD",
  "CAD",
  "CHF",
  "CNY",
  "INR",
  "TRY",
  "LBP",
];

const Map<String, String> currencyToCountryCode = {
  "USD": "US",
  "EUR": "EU",
  "GBP": "GB",
  "JPY": "JP",
  "AUD": "AU",
  "CAD": "CA",
  "CHF": "CH",
  "CNY": "CN",
  "INR": "IN",
  "TRY": "TR",
  "LBP": "LB"
};

class CurrencyService {
  final String apiUrl =
      "https://v6.exchangerate-api.com/v6/$currencyApiKey/latest/USD";

  Future<List<Currency>> fetchCurrencies() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> rates = data['conversion_rates'];

      return rates.entries
          .where((entry) => desiredCurrencies.contains(entry.key))
          .map((entry) => Currency.fromJson(entry.key, entry.value.toDouble()))
          .toList();
    } else {
      throw Exception('Failed to load currency data');
    }
  }
}
