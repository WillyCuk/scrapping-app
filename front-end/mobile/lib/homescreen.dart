import 'package:ai_scrapping_market/api.dart';
import 'package:ai_scrapping_market/utils/itemtile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final List<String> _options = ["Price", "Rating", "Sell Count", "City"];
  String? _option;
  bool _isLoading = false;
  bool _isFilterCity = false;
  bool _isAscending = false;
  String _error = '';

  List<Map<String, dynamic>> _items = [
    {
      "product name":
          "Boneka Baymax Kepala Goyang Pajangan Baymax Mobil Baymax VC",
      "product price": 79800,
      "product rating": 4.5,
      "product sell count": 7,
      "product location": "Tangerang",
      "product shop name": "Global Jaya Shop",
      "product image":
          "https://s2.bukalapak.com/img/2329979603/large/Boneka_Baymax_Kepala_Goyang_Pajangan_Baymax_Mobil_Baymax_VC.jpg",
      "product url":
          "https://www.tokopedia.com/acerstoreofficial/acer-laptop-nitro-v-15-anv15-51-5115-15-6-i5-13420h-8gb-512gb-rtx-4050?source=homepage.top_carousel.0.38456",
      "marketplace": "bukalapak"
    },
    {
      "product name":
          "Boneka Baymax Kepala Goyang Pajangan Baymax Mobil Baymax VC",
      "product price": 79900,
      "product rating": 2.5,
      "product sell count": 6,
      "product location": "Tangerang",
      "product shop name": "Global Jaya Shop",
      "product image":
          "https://s2.bukalapak.com/img/2329979603/large/Boneka_Baymax_Kepala_Goyang_Pajangan_Baymax_Mobil_Baymax_VC.jpg",
      "product url":
          "https://www.tokopedia.com/acerstoreofficial/acer-laptop-nitro-v-15-anv15-51-5115-15-6-i5-13420h-8gb-512gb-rtx-4050?source=homepage.top_carousel.0.38456",
      "marketplace": "bukalapak"
    },
    {
      "product name":
          "Boneka Baymax Kepala Goyang Pajangan Baymax Mobil Baymax VC",
      "product price": 79700,
      "product rating": 5,
      "product sell count": 12,
      "product location": "Medan",
      "product shop name": "Global Jaya Shop",
      "product image": "-",
      "product url":
          "https://www.tokopedia.com/acerstoreofficial/acer-laptop-nitro-v-15-anv15-51-5115-15-6-i5-13420h-8gb-512gb-rtx-4050?source=homepage.top_carousel.0.38456",
      "marketplace": "bukalapak"
    }
  ];

  List<Map<String, dynamic>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_items);
  }

  void _updateData(String query) async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      List<Map<String, dynamic>> result = await fetchData(query);
      setState(() {
        debugPrint(result.toString());
        _items = result;
        _filteredItems = result;
        _isLoading = false;
        debugPrint(_items.toString());
      });
    } catch (error) {
      setState(() {
        _items = [];
        _isLoading = false;
        _error = error.toString();
      });
    }
  }

  void _sortItems(String criteria) {
    setState(() {
      if (criteria == 'Price') {
        _filteredItems.sort((a, b) => _isAscending
            ? a["product price"].compareTo(b["product price"])
            : b["product price"].compareTo(a["product price"]));
      } else if (criteria == 'Rating') {
        _filteredItems.sort((a, b) => _isAscending
            ? a["product rating"].compareTo(b["product rating"])
            : b["product rating"].compareTo(a["product rating"]));
      } else if (criteria == 'Sell Count') {
        _filteredItems.sort((a, b) => _isAscending
            ? a["product sell count"].compareTo(b["product sell count"])
            : b["product sell count"].compareTo(a["product sell count"]));
      }
    });
  }

  void filterCity(String query) {
    final filter = _items
        .where((item) => item['product location']
            .toLowerCase()
            .contains(cityController.text.toLowerCase()))
        .toList();
    setState(() {
      debugPrint(_items.toString());
      _filteredItems = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = const Color.fromARGB(255, 58, 27, 15);
    Color loading = const Color.fromRGBO(58, 27, 15, .6);

    return Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          "Bu & Du",
          style: GoogleFonts.grandifloraOne(
              fontSize: 24, fontWeight: FontWeight.w600),
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "loupe.png",
                    width: 30,
                    height: 30,
                    scale: 1,
                    fit: BoxFit.fill,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color, width: 2.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color, width: 2.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            ElevatedButton(
              onPressed: () =>
                  _isLoading ? null : _updateData(searchController.text),
              style: ElevatedButton.styleFrom(
                  backgroundColor: _isLoading ? loading : color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 54)),
              child: Text(
                "Search",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(
                  child: _isFilterCity
                      ? TextField(
                          controller: cityController,
                          onChanged: filterCity,
                          decoration: InputDecoration(
                            hintText: "City",
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: color, width: 2.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: color, width: 2.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Sort by : ${_option ?? ""}",
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                            _option != null
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isAscending = !_isAscending;
                                        _sortItems(_option!);
                                      });
                                    },
                                    icon: _isAscending
                                        ? const Icon(
                                            Icons.arrow_circle_down,
                                            size: 29,
                                          )
                                        : const Icon(
                                            Icons.arrow_circle_up,
                                            size: 29,
                                          ))
                                : Container(),
                          ],
                        ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * .6,
                            child: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            icon: const Icon(
                                              Icons.close,
                                              size: 38,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          Text(
                                            "Urutkan",
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                              width:
                                                  48), // To balance the layout
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: _options.map((option) {
                                          return RadioListTile<String>(
                                              selectedTileColor: color,
                                              activeColor: color,
                                              value: option,
                                              title: Text(
                                                option,
                                                style: GoogleFonts.poppins(),
                                              ),
                                              groupValue: _option,
                                              onChanged: option == "City"
                                                  ? (String? value) {
                                                      setState(() {
                                                        _option = value;
                                                        _isFilterCity = true;
                                                      });
                                                    }
                                                  : (String? value) {
                                                      setState(() {
                                                        _option = value;
                                                        _isFilterCity = false;
                                                        cityController.text =
                                                            "";
                                                      });
                                                    });
                                        }).toList(),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor: color,
                                              minimumSize: Size(
                                                  MediaQuery.sizeOf(context)
                                                      .width,
                                                  50)),
                                          onPressed: () {
                                            _sortItems(_option!);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Apply",
                                            style: GoogleFonts.poppins(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          )),
                                    )
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.swap_vert,
                      color: Color.fromARGB(255, 58, 27, 15),
                    ),
                  ),
                )
              ]),
            ),
            if (_isLoading)
              Center(
                  child: CircularProgressIndicator(
                      color: color)), // Show loading indicator
            if (!_isLoading && _error.isEmpty) _buildDataList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDataList() {
    if (_items.isEmpty) {
      return const Text("No data");
    }
    return Expanded(
        child: ListView.builder(
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              if (_filteredItems[index]["product image"] == "-") {
                return ItemTile(
                  itemName: _filteredItems[index]["product name"],
                  itemPrice: _filteredItems[index]["product price"].toString(),
                  itemShop: _filteredItems[index]["product shop name"],
                  itemRating: double.parse(
                      _filteredItems[index]["product rating"].toString()),
                  itemSell:
                      _filteredItems[index]["product sell count"].toString(),
                  itemShopLoc: _filteredItems[index]["product location"],
                  itemUrl: _filteredItems[index]["product url"],
                  marketplace: _filteredItems[index]["marketplace"],
                );
              }
              return ImageItemTile(
                imgPath: _filteredItems[index]["product image"],
                itemName: _filteredItems[index]["product name"],
                itemPrice: _filteredItems[index]["product price"].toString(),
                itemShop: _filteredItems[index]["product shop name"],
                itemRating: double.parse(
                    _filteredItems[index]["product rating"].toString()),
                itemSell:
                    _filteredItems[index]["product sell count"].toString(),
                itemShopLoc: _filteredItems[index]["product location"],
                itemUrl: _filteredItems[index]["product url"],
                marketplace: _filteredItems[index]["marketplace"],
              );
            }));
  }
}
