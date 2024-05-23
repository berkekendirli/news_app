import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/screens/all_breaking.dart';
import 'package:news_app/screens/article_view.dart';
import 'package:news_app/screens/category_page.dart';
import 'package:news_app/screens/search_page.dart';
import 'package:news_app/services/category_data.dart';
import 'package:news_app/services/slider_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategoryName;
  List<sliderModel> sliders = [];
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  final TextEditingController _searchController = TextEditingController();
  bool _showClearIcon = false;
  int _selectedCategoryIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    selectedCategoryName = categories[_selectedCategoryIndex].categoryName;
  }

  Future<void> fetchData() async {
    categories = getCategory();
    await getSlider();
    setState(() {
      _loading = false;
    });
  }

  Future<void> getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 255, 58, 68),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Container(
                color: Colors.white,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 32,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextField(
                                        textInputAction: TextInputAction.search,
                                        controller: _searchController,
                                        onChanged: (value) {
                                          setState(() {
                                            _showClearIcon = value.isNotEmpty;
                                          });
                                        },
                                        onSubmitted: (_) {
                                          String searchQuery =
                                              _searchController.text;
                                          if (searchQuery.isNotEmpty) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchPage(
                                                        searchQuery:
                                                            searchQuery),
                                              ),
                                            );
                                            setState(() {
                                              _searchController.clear();
                                              _showClearIcon = false;
                                            });
                                          }
                                        },
                                        // textAlignVertical: TextAlignVertical.bottom,
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          hintStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                146, 129, 129, 129),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 240, 241, 250),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(255, 82, 82,
                                                  82), // Change to your desired color
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          suffixIcon: _showClearIcon
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _searchController.clear();
                                                      _showClearIcon = false;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.clear,
                                                    color: Color.fromARGB(
                                                        146, 129, 129, 129),
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons.search,
                                                  color: Color.fromARGB(
                                                      146, 129, 129, 129),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Breaking News',
                                style: GoogleFonts.ptSerif(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BreakingPage(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'See All',
                                      style: GoogleFonts.nunito(
                                          color: const Color.fromARGB(
                                              255, 0, 128, 255),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Color.fromARGB(255, 0, 128, 255),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        buildSlider(),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 7,
                          ),
                          child: SizedBox(
                            height: 32,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                String categoryName =
                                    categories[index].categoryName!;
                                return buildCategoryTile(categoryName, index);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: selectedCategoryName != null
                              ? CategoryNews(name: selectedCategoryName!)
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget buildCategoryTile(String categoryName, int index) {
    bool isSelected = index == _selectedCategoryIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
          selectedCategoryName = categoryName;
        });
      },
      child: AnimatedContainer(
        curve: Curves.easeInCubic,
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? null : Colors.white,
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 58, 68),
                    Color.fromARGB(255, 255, 128, 134)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: isSelected
                ? const Color.fromARGB(255, 255, 179, 182)
                : const Color.fromARGB(255, 240, 241, 250),
          ),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: GoogleFonts.nunito(
              color: isSelected
                  ? Colors.white
                  : const Color.fromARGB(255, 46, 5, 5),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSlider() {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) {
        String? res = sliders[index].urlToImage;
        String? res1 = sliders[index].title;
        String? res2 = sliders[index].url;
        String? res3 = sliders[index].source;
        String? res4 = sliders[index].description;
        return buildImage(res!, index, res1!, res2!, res3!, res4!);
      },
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 8),
        autoPlayAnimationDuration: const Duration(milliseconds: 1650),
        autoPlay: true,
        height: 240,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
    );
  }

  Widget buildImage(String image, int index, String name, String url,
          String source, String desc) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(
                urlToImage: image,
                title: name,
                source: source,
                blogUrl: url,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(94, 0, 0, 0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.ptSerif(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          source,
                          style: GoogleFonts.nunito(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
