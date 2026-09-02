import 'package:api_learning/models/product_model.dart';
import 'package:api_learning/services/get_api_services.dart';
import 'package:flutter/material.dart';

class ProductScreens extends StatefulWidget {
  const ProductScreens({super.key});

  @override
  State<ProductScreens> createState() => _ProductScreensState();
}

class _ProductScreensState extends State<ProductScreens> {
  final GetApiServices apiServices = GetApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F9),
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        titleSpacing: 4,

        title: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF202124),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 21),
            ),

            const SizedBox(width: 12),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.4,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "API Data Explorer",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.black.withOpacity(0.05)),
        ),
      ),

      body: FutureBuilder<ProductModel>(
        future: apiServices.getProdcut(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _errorWidget(message: "Something went wrong", error: snapshot.error.toString());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No Products Found"));
          }

          final data = snapshot.data!;
          final products = data.products ?? [];

          if (products.isEmpty) {
            return const Center(child: Text("No Products Available"));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================================
              // INTRO
              // =========================================================

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 2, 20, 18),
                child: Text(
                  "Explore products fetched from the API.",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ),

              // =========================================================
              // PRODUCT COUNT
              // =========================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.inventory_2_outlined, size: 17),
                          const SizedBox(width: 7),
                          Text(
                            "${products.length} Products",
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // =========================================================
              // PRODUCTS LIST
              // =========================================================
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final item = products[index];

                    return _productCard(item: item, index: index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ===================================================================
  // PRODUCT CARD
  // ===================================================================

  Widget _productCard({required Products item, required int index}) {
    final image =
        item.thumbnail ??
        (item.images != null && item.images!.isNotEmpty ? item.images!.first : "");

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // IMAGE
            // =========================================================

            Stack(
              children: [
                SizedBox(
                  height: 210,
                  width: double.infinity,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 45,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // =====================================================
                // PRODUCT NUMBER
                // =====================================================
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    height: 36,
                    width: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.72),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                // =====================================================
                // DISCOUNT
                // =====================================================
                if (item.discountPercentage != null)
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE85D04),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${item.discountPercentage!.toStringAsFixed(0)}% OFF",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // =========================================================
            // PRODUCT CONTENT
            // =========================================================
            Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.category ?? "Product",
                      style: const TextStyle(
                        color: Color(0xFF4F46E5),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Title
                  Text(
                    item.title ?? "Untitled Product",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Description
                  Text(
                    item.description ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, height: 1.4, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 15),

                  // =====================================================
                  // RATING + STOCK
                  // =====================================================
                  Row(
                    children: [
                      // Rating
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4DA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 17, color: Color(0xFFFFA000)),
                            const SizedBox(width: 4),
                            Text(
                              "${item.rating ?? 0}",
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 9),

                      // Stock
                      if (item.stock != null)
                        Text(
                          "${item.stock} in stock",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                      const Spacer(),

                      // Price
                      Text(
                        "\$${item.price ?? 0}",
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // =====================================================
                  // BOTTOM ACTION
                  // =====================================================
                  Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF202124),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "View Product Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================================
  // ERROR WIDGET
  // ===================================================================

  Widget _errorWidget({required String message, required String error}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 55, color: Colors.grey),
            const SizedBox(height: 15),
            Text(message, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
