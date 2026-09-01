import 'package:api_learning/screens/recepie_detail_screen.dart';
import 'package:api_learning/services/get_recepie_api.dart';
import 'package:flutter/material.dart';

class RecepieScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RecepieScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<RecepieScreen> {
  GetRecepieApi recepieApi = GetRecepieApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recepie Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: recepieApi.getRecepie(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No Data"));
          }
          final data = snapshot.data;
          final recepieDataList = data!.recipes ?? [];

          return Expanded(
            child: ListView.builder(
              itemCount: recepieDataList.length,
              itemBuilder: (context, index) {
                final recepieItem = recepieDataList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecepieDetailScreen(recpieItem: recepieItem),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            recepieItem.image.toString(),
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recepieItem.name.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                recepieItem.cuisine.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),

                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  const Icon(Icons.star, size: 18, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(recepieItem.rating.toString()),
                                  const SizedBox(width: 12),
                                  Text("${recepieItem.reviewCount} reviews"),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "${recepieItem.prepTimeMinutes} min prep • "
                                "${recepieItem.cookTimeMinutes} min cook",
                                style: const TextStyle(fontSize: 13),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "${recepieItem.difficulty} • "
                                "${recepieItem.servings} servings",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
