import 'package:api_learning/models/recepie_model.dart';
import 'package:flutter/material.dart';

class RecepieDetailScreen extends StatelessWidget {
  final Recipes recpieItem;

  const RecepieDetailScreen({super.key, required this.recpieItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F6),

      body: CustomScrollView(
        slivers: [
          // ============================================================
          // HERO IMAGE
          // ============================================================

          SliverAppBar(
            expandedHeight: 330,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    recpieItem.image ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.restaurant, size: 60, color: Colors.grey),
                      );
                    },
                  ),

                  // Dark gradient for readability
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.15),
                          Colors.transparent,
                          Colors.black.withOpacity(0.75),
                        ],
                      ),
                    ),
                  ),

                  // Difficulty badge
                  Positioned(
                    top: 55,
                    right: 18,
                    child: _badge(
                      text: recpieItem.difficulty ?? "Unknown",
                      icon: Icons.speed_rounded,
                    ),
                  ),

                  // Bottom hero content
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cuisine
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            recpieItem.cuisine ?? "Recipe",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF242424),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Name
                        Text(
                          recpieItem.name ?? "Untitled Recipe",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 29,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Back button
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: _circleButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // ============================================================
          // CONTENT
          // ============================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ======================================================
                  // RATING
                  // ======================================================

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2D8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFFFA000), size: 21),
                            const SizedBox(width: 5),
                            Text(
                              "${recpieItem.rating ?? 0}",
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "${recpieItem.reviewCount ?? 0} reviews",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ======================================================
                  // QUICK INFO
                  // ======================================================
                  const Text(
                    "Recipe Information",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),

                  const SizedBox(height: 13),

                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          icon: Icons.schedule_rounded,
                          label: "Prep",
                          value: "${recpieItem.prepTimeMinutes ?? 0} min",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoCard(
                          icon: Icons.local_fire_department_rounded,
                          label: "Cook",
                          value: "${recpieItem.cookTimeMinutes ?? 0} min",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          icon: Icons.people_alt_outlined,
                          label: "Servings",
                          value: "${recpieItem.servings ?? 0}",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoCard(
                          icon: Icons.whatshot_rounded,
                          label: "Calories",
                          value: "${recpieItem.caloriesPerServing ?? 0}",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ======================================================
                  // INGREDIENTS
                  // ======================================================
                  _sectionHeader(
                    icon: Icons.shopping_basket_outlined,
                    title: "Ingredients",
                    count: recpieItem.ingredients?.length,
                  ),

                  const SizedBox(height: 14),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: List.generate(recpieItem.ingredients?.length ?? 0, (index) {
                        final ingredient = recpieItem.ingredients![index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 34,
                                width: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1DC),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    color: Color(0xFFE58A00),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 13),

                              Expanded(
                                child: Text(
                                  ingredient,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.35,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ======================================================
                  // INSTRUCTIONS
                  // ======================================================
                  _sectionHeader(
                    icon: Icons.menu_book_rounded,
                    title: "Instructions",
                    count: recpieItem.instructions?.length,
                  ),

                  const SizedBox(height: 14),

                  Column(
                    children: List.generate(recpieItem.instructions?.length ?? 0, (index) {
                      final instruction = recpieItem.instructions![index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Number
                            Container(
                              height: 38,
                              width: 38,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF202020),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Instruction
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(17),
                                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                                ),
                                child: Text(
                                  instruction,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 18),

                  // ======================================================
                  // TAGS
                  // ======================================================
                  _sectionHeader(icon: Icons.local_offer_outlined, title: "Tags"),

                  const SizedBox(height: 13),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(recpieItem.tags?.length ?? 0, (index) {
                      return _tag(recpieItem.tags![index]);
                    }),
                  ),

                  const SizedBox(height: 28),

                  // ======================================================
                  // MEAL TYPE
                  // ======================================================
                  _sectionHeader(icon: Icons.restaurant_menu_rounded, title: "Meal Type"),

                  const SizedBox(height: 13),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(recpieItem.mealType?.length ?? 0, (index) {
                      return _mealTag(recpieItem.mealType![index]);
                    }),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SECTION HEADER
  // ================================================================

  Widget _sectionHeader({required IconData icon, required String title, int? count}) {
    return Row(
      children: [
        Icon(icon, size: 21, color: const Color(0xFFE58A00)),

        const SizedBox(width: 8),

        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.3),
        ),

        if (count != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "$count",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ],
    );
  }

  // ================================================================
  // INFO CARD
  // ================================================================

  Widget _infoCard({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 21, color: Colors.black87),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // HERO BADGE
  // ================================================================

  Widget _badge({required String text, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.black87),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  // ================================================================
  // CIRCLE BUTTON
  // ================================================================

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.black.withOpacity(0.45),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(height: 42, width: 42, child: Icon(icon, size: 19)),
      ),
    );
  }

  // ================================================================
  // TAG
  // ================================================================

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1DC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "# $text",
        style: const TextStyle(color: Color(0xFFB96B00), fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );
  }

  // ================================================================
  // MEAL TAG
  // ================================================================

  Widget _mealTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F6ED),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.restaurant_rounded, size: 15, color: Color(0xFF31824B)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF31824B),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
