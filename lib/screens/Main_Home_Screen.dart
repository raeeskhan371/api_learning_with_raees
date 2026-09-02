import 'package:api_learning/screens/products/product_screens.dart';
import 'package:api_learning/screens/recepie.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================================
              // HEADER
              // =========================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WELCOME TO",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade500,
                            letterSpacing: 1.5,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "API Explorer",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Learn how APIs work by exploring real data.",
                          style: TextStyle(fontSize: 14, height: 1.4, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.api_rounded, color: Colors.white, size: 27),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // =========================================================
              // HOW IT WORKS
              // =========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: const Icon(
                            Icons.lightbulb_outline_rounded,
                            color: Color(0xFF4169E1),
                            size: 21,
                          ),
                        ),

                        const SizedBox(width: 11),

                        const Text(
                          "How this app works",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "Choose a category below. The app will fetch "
                      "data from its API, parse the response, and "
                      "display it in a user-friendly interface.",
                      style: TextStyle(fontSize: 13, height: 1.5, color: Colors.grey.shade600),
                    ),

                    const SizedBox(height: 18),

                    // Flow
                    Row(
                      children: [
                        _flowItem(icon: Icons.touch_app_outlined, title: "Choose"),

                        _flowLine(),

                        _flowItem(icon: Icons.cloud_download_outlined, title: "Fetch API"),

                        _flowLine(),

                        _flowItem(icon: Icons.data_object_rounded, title: "Display"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =========================================================
              // CATEGORY TITLE
              // =========================================================
              const Text(
                "Explore APIs",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.4),
              ),

              const SizedBox(height: 5),

              Text(
                "Select what you want to explore",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 15),

              // =========================================================
              // PRODUCTS
              // =========================================================
              _ApiCard(
                title: "Products",
                description: "Fetch product data, prices and details.",
                category: "PRODUCT API",
                icon: Icons.shopping_bag_outlined,
                imageUrl: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=1000&q=80",
                accentColor: const Color(0xFF4F46E5),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductScreens()),
                  );
                },
              ),

              const SizedBox(height: 15),

              // =========================================================
              // RECIPES
              // =========================================================
              _ApiCard(
                title: "Recipes",
                description: "Explore recipes, ingredients and instructions.",
                category: "RECIPE API",
                icon: Icons.restaurant_menu_rounded,
                imageUrl: "https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=1000&q=80",
                accentColor: const Color(0xFFE85D04),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RecepieScreen()));
                },
              ),

              const SizedBox(height: 15),

              // =========================================================
              // BOOKS
              // =========================================================
              _ApiCard(
                title: "Books",
                description: "Discover books and explore their information.",
                category: "BOOK API",
                icon: Icons.menu_book_rounded,
                imageUrl: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=1000&q=80",
                accentColor: const Color(0xFF16803C),
                onTap: () {
                  // Navigate to Books Screen
                  //
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const BooksScreen(),
                  //   ),
                  // );
                },
              ),

              const SizedBox(height: 28),

              // =========================================================
              // BOTTOM EXPLANATION
              // =========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color(0xFF202124),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.code_rounded, color: Colors.white, size: 22),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "What you'll practice",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "HTTP requests • JSON parsing • Models • "
                            "ListView • Navigation • API responses",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.65),
                              fontSize: 12,
                              height: 1.5,
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
        ),
      ),
    );
  }

  // ================================================================
  // FLOW ITEM
  // ================================================================

  Widget _flowItem({required IconData icon, required String title}) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 21, color: Colors.black87),

          const SizedBox(height: 6),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // FLOW LINE
  // ================================================================

  Widget _flowLine() {
    return Container(
      width: 25,
      height: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.only(bottom: 18),
    );
  }
}

// ====================================================================
// API CARD
// ====================================================================

class _ApiCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _ApiCard({
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 205,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),

          child: Stack(
            fit: StackFit.expand,
            children: [
              // ========================================================
              // IMAGE
              // ========================================================

              Image.network(
                imageUrl,
                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 45,
                      color: Colors.grey,
                    ),
                  );
                },
              ),

              // ========================================================
              // GRADIENT
              // ========================================================
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.82),
                    ],
                  ),
                ),
              ),

              // ========================================================
              // TOP LEFT CATEGORY
              // ========================================================
              Positioned(
                top: 16,
                left: 16,

                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.93),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 15, color: accentColor),

                      const SizedBox(width: 6),

                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ========================================================
              // ARROW
              // ========================================================
              Positioned(
                top: 16,
                right: 16,

                child: Container(
                  height: 43,
                  width: 43,

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.93),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 21),
                ),
              ),

              // ========================================================
              // BOTTOM CONTENT
              // ========================================================
              Positioned(
                left: 18,
                right: 18,
                bottom: 17,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.82),
                              fontSize: 13,
                              height: 1.35,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Explore label
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Explore",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
