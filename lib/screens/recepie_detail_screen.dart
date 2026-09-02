import 'package:api_learning/models/recepie_model.dart';
import 'package:flutter/material.dart';

class RecepieDetailScreen extends StatefulWidget {
  final Recipes recpieItem;
  new({required this.recpieItem});

  @override
  State<RecepieDetailScreen> createState() => _RecepieDetailScreenState();
}

class _RecepieDetailScreenState extends State<RecepieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recepie Detail Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade300,
                image: DecorationImage(
                  image: NetworkImage(widget.recpieItem.image.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              widget.recpieItem.name.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(widget.recpieItem.cuisine.toString()),
            Text(widget.recpieItem.difficulty.toString()),
            Text(widget.recpieItem.rating.toString()),
            Text(widget.recpieItem.reviewCount.toString()),
            Text(widget.recpieItem.prepTimeMinutes.toString()),
            Text(widget.recpieItem.cookTimeMinutes.toString()),
            Text(widget.recpieItem.servings.toString()),
            Text(widget.recpieItem.caloriesPerServing.toString()),

            const SizedBox(height: 16),

            Text("Ingredients", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            Expanded(
              child: ListView.builder(
                itemCount: widget.recpieItem.ingredients?.length,

                itemBuilder: (context, index) {
                  final indegredients = widget.recpieItem.ingredients?[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${index + 1}"),
                          SizedBox(width: 5),
                          Text("${indegredients.toString()}"),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Text("Instructions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            Expanded(
              child: ListView.builder(
                itemCount: widget.recpieItem.instructions?.length,

                itemBuilder: (context, index) {
                  final instructions = widget.recpieItem.instructions?[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${index + 1}."),
                          const SizedBox(width: 5),
                          Expanded(child: Text(instructions.toString(), softWrap: true)),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: 16),

            Text("${widget.recpieItem.tags.toString()}"),
            Text(widget.recpieItem.mealType.toString()),
          ],
        ),
      ),
    );
  }
}
