// lib/currency_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/currency_model.dart';
import 'package:news_app/services/currency_data.dart';
import 'package:news_app/services/currency_country.dart'; // Import the mapping

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  late Future<List<Currency>> futureCurrencies;
  String? selectedBaseCurrency;
  List<String> selectedTargetCurrencies = [];

  @override
  void initState() {
    super.initState();
    futureCurrencies =
        CurrencyService(targetCurrencies: desiredCurrencies).fetchCurrencies();
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedBaseCurrency = this.selectedBaseCurrency;
        List<String> selectedTargetCurrencies =
            List.from(this.selectedTargetCurrencies);
        List<bool> selectedStates = desiredCurrencies
            .map((currency) => selectedTargetCurrencies.contains(currency))
            .toList();

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Filter Currencies',
                  style: GoogleFonts.ptSerif(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select base currency',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    DropdownButton<String>(
                      value: selectedBaseCurrency,
                      onChanged: (newValue) {
                        setState(() {
                          selectedBaseCurrency = newValue;
                        });
                      },
                      items: desiredCurrencies
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTargetCurrencies =
                                        List.from(desiredCurrencies);
                                    selectedStates = List.filled(
                                        desiredCurrencies.length, true);
                                  });
                                },
                                child: Text(
                                  'Select All',
                                  style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTargetCurrencies = [];
                                    selectedStates = List.filled(
                                        desiredCurrencies.length, false);
                                  });
                                },
                                child: Text(
                                  'Deselect All',
                                  style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Select Target Currencies',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    ListBody(
                      children: desiredCurrencies.asMap().entries.map((entry) {
                        final index = entry.key;
                        final currency = entry.value;
                        final countryCode =
                            currencyToCountryCode[currency]?.toLowerCase() ??
                                "un";
                        return CheckboxListTile(
                          activeColor: const Color.fromARGB(255, 255, 58, 68),
                          title: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 97, 97, 97),
                                  ),
                                ),
                                child: ClipRRect(
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
                              ),
                              const SizedBox(width: 8),
                              Text(
                                currency,
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          value: selectedStates[index],
                          onChanged: (bool? checked) {
                            setState(() {
                              if (checked == true) {
                                selectedTargetCurrencies.add(currency);
                                selectedStates[index] = true;
                              } else {
                                selectedTargetCurrencies.remove(currency);
                                selectedStates[index] = false;
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Apply',
                    style: GoogleFonts.nunito(
                      color: const Color.fromARGB(255, 255, 58, 68),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateCurrencies(
                        selectedBaseCurrency!, selectedTargetCurrencies);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateCurrencies(String baseCurrency, List<String> targetCurrencies) {
    setState(() {
      futureCurrencies = CurrencyService(
              baseCurrency: baseCurrency, targetCurrencies: targetCurrencies)
          .fetchCurrencies();
    });
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_list,
            ),
            onPressed: () {
              _showFilterDialog(context);
            },
          )
        ],
      ),
      body: FutureBuilder<List<Currency>>(
        future: futureCurrencies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 58, 68),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No data available',
                style: GoogleFonts.nunito(color: Colors.black, fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length * 2 - 1,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Container(color: Colors.white, child: const Divider());
                }

                final currencyIndex = index ~/ 2;
                final currency = snapshot.data![currencyIndex];
                final countryCode =
                    currencyToCountryCode[currency.code]?.toLowerCase() ?? "un";
                return ListTile(
                  tileColor: Colors.white,
                  leading: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color.fromARGB(255, 97, 97, 97),
                      ),
                    ),
                    child: ClipRRect(
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
