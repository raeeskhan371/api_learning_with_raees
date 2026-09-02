import 'package:api_learning/models/recepie_model.dart';
import 'package:flutter/material.dart';

class RecepieDetailScreen extends StatelessWidget {
  final Recipes recpieItem;

  const RecepieDetailScreen({super.key, required this.recpieItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        title: const Text("Recipe Details", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE =================

            Stack(
              children: [
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Image.network(recpieItem.image.toString(), fit: BoxFit.cover),
                ),

                // Gradient
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                      ),
                    ),
                  ),
                ),

                // Difficulty
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      recpieItem.difficulty.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // Recipe Name
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 18,
                  child: Text(
                    recpieItem.name.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // ================= MAIN CONTENT =================
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cuisine + Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.restaurant, size: 19, color: Colors.orange),
                          const SizedBox(width: 6),
                          Text(
                            recpieItem.cuisine.toString(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 18, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              "${recpieItem.rating} (${recpieItem.reviewCount})",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // ================= INFO CARDS =================
                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          icon: Icons.timer_outlined,
                          title: "Prep Time",
                          value: "${recpieItem.prepTimeMinutes} min",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoCard(
                          icon: Icons.local_fire_department_outlined,
                          title: "Cook Time",
                          value: "${recpieItem.cookTimeMinutes} min",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          icon: Icons.people_outline,
                          title: "Servings",
                          value: "${recpieItem.servings}",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoCard(
                          icon: Icons.local_fire_department,
                          title: "Calories",
                          value: "${recpieItem.caloriesPerServing}",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ================= INGREDIENTS =================
                  _sectionTitle(icon: Icons.shopping_basket_outlined, title: "Ingredients"),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: List.generate(recpieItem.ingredients?.length ?? 0, (index) {
                        final ingredient = recpieItem.ingredients![index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 27,
                                width: 27,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  ingredient,
                                  style: const TextStyle(fontSize: 15, height: 1.4),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ================= INSTRUCTIONS =================
                  _sectionTitle(icon: Icons.menu_book_outlined, title: "Instructions"),

                  const SizedBox(height: 12),

                  Column(
                    children: List.generate(recpieItem.instructions?.length ?? 0, (index) {
                      final instruction = recpieItem.instructions![index];

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 34,
                              width: 34,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                instruction,
                                style: const TextStyle(fontSize: 15, height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 16),

                  // ================= TAGS =================
                  _sectionTitle(icon: Icons.local_offer_outlined, title: "Tags"),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(recpieItem.tags?.length ?? 0, (index) {
                      return Chip(
                        label: Text(recpieItem.tags![index]),
                        backgroundColor: Colors.orange.shade50,
                        side: BorderSide.none,
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  // ================= MEAL TYPE =================
                  _sectionTitle(icon: Icons.restaurant_menu, title: "Meal Type"),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    children: List.generate(recpieItem.mealType?.length ?? 0, (index) {
                      return Chip(
                        label: Text(recpieItem.mealType![index]),
                        backgroundColor: Colors.green.shade50,
                        side: BorderSide.none,
                      );
                    }),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= INFO CARD =================

  Widget _infoCard({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue.shade700, size: 21),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 3),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= SECTION TITLE =================

  Widget _sectionTitle({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, size: 21, color: Colors.blue.shade700),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
