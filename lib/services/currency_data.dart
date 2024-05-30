// lib/services/currency_data.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/currency_model.dart';
import 'package:news_app/services/api_key.dart';

const List<String> desiredCurrencies = [
   "AED", "AFN", "ALL", "AMD",  "AOA", "ARS", "AUD", "AWG", "AZN", 
  "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BSD", 
  "BTN", "BWP", "BYN", "BZD", "CAD", "CDF", "CHF", "CLP", "CNY", "COP", "CRC", 
  "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", "EGP", "ERN", "ETB", "EUR", 
  "FJD", "FKP", "FOK", "GBP", "GEL", "GGP", "GHS", "GIP", "GMD", "GNF", "GTQ", 
  "GYD", "HKD", "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "IMP", "INR", "IQD", 
  "IRR", "ISK", "JEP", "JMD", "JOD", "JPY", "KES", "KGS", "KHR", "KID", "KMF", 
  "KRW", "KWD", "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LYD", "MAD", 
  "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRU", "MUR", "MVR", "MWK", "MXN", 
  "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", 
  "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF", "SAR", 
  "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLE", "SLL", "SOS", "SRD", "SSP", 
  "STN", "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TVD", 
  "TWD", "TZS", "UAH", "UGX", "USD", "UYU", "UZS", "VES", "VND", "VUV", "WST", "XAF", 
  "XCD", "XDR", "XOF", "XPF", "YER", "ZAR", "ZMW", "ZWL"
];

class CurrencyService {
  final String baseCurrency;
  final List<String> targetCurrencies;

  CurrencyService({this.baseCurrency = 'USD', required this.targetCurrencies});

  Future<List<Currency>> fetchCurrencies() async {
    final apiUrl =
        "https://v6.exchangerate-api.com/v6/$currencyApiKey/latest/$baseCurrency";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> rates = data['conversion_rates'];

      return rates.entries
          .where((entry) => targetCurrencies.contains(entry.key))
          .map((entry) => Currency.fromJson(entry.key, entry.value.toDouble()))
          .toList();
    } else {
      throw Exception('Failed to load currency data');
    }
  }
}
