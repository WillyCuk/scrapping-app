import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageItemTile extends StatelessWidget {
  final String imgPath;
  final String itemName;
  final String itemPrice;
  final String itemShop;
  final double itemRating;
  final String itemSell;
  final String itemShopLoc;
  final String itemUrl;
  final String marketplace;
  const ImageItemTile(
      {super.key,
      required this.imgPath,
      required this.itemName,
      required this.itemPrice,
      required this.itemShop,
      required this.itemRating,
      required this.itemSell,
      required this.itemShopLoc,
      required this.itemUrl,
      required this.marketplace});

  @override
  Widget build(BuildContext context) {
    Color backgroundRating = const Color.fromRGBO(54, 25, 25, 0.4);
    Color starColor = const Color.fromARGB(255, 253, 211, 106);
    return GestureDetector(
      onTap: () => _launchUrl(itemUrl),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .3,
              height: MediaQuery.sizeOf(context).width * .3,
              child: Image.network(
                imgPath,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: GoogleFonts.grandifloraOne(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "Rp. $itemPrice",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  const SizedBox(height: 7.0),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6.0),
                          width: 65,
                          decoration: BoxDecoration(
                            color: backgroundRating,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: starColor,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                itemRating.toString(),
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                        ),
                        Text(
                          "$itemSell terjual",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .13,
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  itemShopLoc,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .13,
                          child: Row(
                            children: [
                              const Icon(Icons.store, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  itemShop,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .13,
                          child: Row(
                            children: [
                              const Icon(Icons.shopping_cart, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  marketplace,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }
}

class ItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemShop;
  final double itemRating;
  final String itemSell;
  final String itemShopLoc;
  final String itemUrl;
  final String marketplace;
  const ItemTile(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.itemShop,
      required this.itemRating,
      required this.itemSell,
      required this.itemShopLoc,
      required this.itemUrl,
      required this.marketplace});

  @override
  Widget build(BuildContext context) {
    Color backgroundRating = const Color.fromRGBO(54, 25, 25, 0.4);
    Color starColor = const Color.fromARGB(255, 253, 211, 106);
    return GestureDetector(
      onTap: () => _launchUrl(itemUrl),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: GoogleFonts.grandifloraOne(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "Rp. $itemPrice",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  const SizedBox(height: 7.0),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6.0),
                          width: 65,
                          decoration: BoxDecoration(
                            color: backgroundRating,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: starColor,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                itemRating.toString(),
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                        ),
                        Text(
                          "$itemSell terjual",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .13,
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  itemShopLoc,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .13,
                          child: Row(
                            children: [
                              const Icon(Icons.store, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  itemShop,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .13,
                          child: Row(
                            children: [
                              const Icon(Icons.shopping_cart, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  marketplace,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }
}
