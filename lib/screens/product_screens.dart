import 'package:api_learning/models/product_model.dart';
import 'package:api_learning/services/get_api_services.dart';
import 'package:flutter/material.dart';

class ProductScreens extends StatefulWidget {
  const new({super.key});

  @override
  State<ProductScreens> createState() => _ProductScreensState();
}

class _ProductScreensState extends State<ProductScreens> {
  GetApiServices apiServices = GetApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
              future: apiServices.getProdcut(),
              builder: (context, snapshot) {
                debugPrint("STATE: ${snapshot.connectionState}");
                debugPrint("DATA: ${snapshot.data}");
                debugPrint("ERROR: ${snapshot.error}");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }

                if (snapshot.hasError) {
                  return Expanded(child: Center(child: Text("Error: ${snapshot.error}")));
                }

                if (!snapshot.hasData) {
                  return const Expanded(child: Center(child: Text("No Data Found")));
                }

                final data = snapshot.data!;
                final products = data.products ?? [];

                return Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final item = products[index];

                      return ListTile(
                        leading: Text("${(index + 1).toString()}"),
                        title: Text(item.title ?? ""),
                        subtitle: Text(item.category ?? ""),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(item.price.toString()),
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ListView.builder(
                                itemCount: item.images!.length,
                                itemBuilder: (context, position) {
                                  final image = item.images?[position];
                                  return CircleAvatar(backgroundImage: NetworkImage(image ?? ""));
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
