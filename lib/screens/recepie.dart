import 'package:api_learning/screens/recepie_detail_screen.dart';
import 'package:api_learning/services/get_recepie_api.dart';
import 'package:flutter/material.dart';

class RecepieScreen extends StatefulWidget {
  const RecepieScreen({super.key});

  @override
  State<RecepieScreen> createState() => _RecepieScreenState();
}

class _RecepieScreenState extends State<RecepieScreen> {
  final GetRecepieApi recepieApi = GetRecepieApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),

      // ===============================================================
      // APP BAR
      // ===============================================================
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F9),
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
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
              child: const Icon(Icons.restaurant_rounded, color: Colors.white, size: 21),
            ),

            const SizedBox(width: 12),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recipes",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, letterSpacing: -0.4),
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

      // ===============================================================
      // API
      // ===============================================================
      body: FutureBuilder(
        future: recepieApi.getRecepie(),
        builder: (context, snapshot) {
          // -------------------------------------------------------------
          // LOADING
          // -------------------------------------------------------------

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // -------------------------------------------------------------
          // ERROR
          // -------------------------------------------------------------

          if (snapshot.hasError) {
            return _errorWidget(error: snapshot.error.toString());
          }

          // -------------------------------------------------------------
          // NO DATA
          // -------------------------------------------------------------

          if (!snapshot.hasData) {
            return const Center(child: Text("No Recipes Found"));
          }

          final data = snapshot.data!;
          final recipes = data.recipes ?? [];

          // -------------------------------------------------------------
          // EMPTY
          // -------------------------------------------------------------

          if (recipes.isEmpty) {
            return const Center(child: Text("No Recipes Available"));
          }

          // -------------------------------------------------------------
          // CONTENT
          // -------------------------------------------------------------

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================================
              // INTRO
              // =========================================================

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                child: Text(
                  "Explore recipes fetched from the API.",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ),

              // =========================================================
              // COUNT
              // =========================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.restaurant_menu_rounded, size: 17),
                      const SizedBox(width: 7),
                      Text(
                        "${recipes.length} Recipes",
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =========================================================
              // LIST
              // =========================================================
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];

                    return _recipeCard(
                      recipe: recipe,
                      index: index,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecepieDetailScreen(recpieItem: recipe),
                          ),
                        );
                      },
                    );
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
  // RECIPE CARD
  // ===================================================================

  Widget _recipeCard({required dynamic recipe, required int index, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
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
                      recipe.image.toString(),
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

                  // Recipe Number
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
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  // Difficulty
                  if (recipe.difficulty != null)
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          recipe.difficulty.toString(),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                ],
              ),

              // =========================================================
              // CONTENT
              // =========================================================
              Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cuisine

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        recipe.cuisine.toString(),
                        style: const TextStyle(
                          color: Color(0xFF4F46E5),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Name
                    Text(
                      recipe.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.2,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Rating + Reviews
                    Row(
                      children: [
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
                                recipe.rating.toString(),
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 9),

                        Text(
                          "${recipe.reviewCount} reviews",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          "${recipe.servings} servings",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Time
                    Row(
                      children: [
                        const Icon(Icons.schedule_rounded, size: 17, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          "${recipe.prepTimeMinutes} min prep",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text("•", style: TextStyle(color: Colors.grey.shade400)),
                        const SizedBox(width: 12),
                        Text(
                          "${recipe.cookTimeMinutes} min cook",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ===================================================
                    // DETAIL BUTTON
                    // ===================================================
                    Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF202124),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "View Recipe Details",
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
      ),
    );
  }

  // ===================================================================
  // ERROR
  // ===================================================================

  Widget _errorWidget({required String error}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 55, color: Colors.grey),
            const SizedBox(height: 15),
            const Text(
              "Something went wrong",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
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
