// lib/currency_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/currency_model.dart';
import 'package:news_app/services/currency_data.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  late Future<List<Currency>> futureCurrencies;

  @override
  void initState() {
    super.initState();
    futureCurrencies = CurrencyService().fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Currency',
              style: GoogleFonts.ptSerif(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              'Rates',
              style: GoogleFonts.ptSerif(
                  color: const Color.fromARGB(255, 255, 58, 68),
                  fontWeight: FontWeight.w800,
                  fontSize: 22),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: FutureBuilder<List<Currency>>(
        future: futureCurrencies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 255, 58, 68)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No data available',
                style: GoogleFonts.nunito(color: Colors.black, fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length * 2 -
                  1, // Double the itemCount to include dividers
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  // Add a divider if the index is odd
                  return const Divider();
                }

                final currencyIndex =
                    index ~/ 2; // Adjusted index to account for dividers
                final currency = snapshot.data![currencyIndex];
                final countryCode =
                    currencyToCountryCode[currency.code]?.toLowerCase() ?? "un";
                return ListTile(
                  tileColor: Colors.white,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SvgPicture.asset(
                      'assets/flags/$countryCode.svg',
                      width: 32,
                      height: 32,
                      placeholderBuilder: (context) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors.grey[700],
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    currency.code,
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  trailing: Text(
                    currency.rate.toStringAsFixed(3),
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ), // Display only two decimal places
                );
              },
            );
          }
        },
      ),
    );
  }
}
