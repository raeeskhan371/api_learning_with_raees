import 'package:api_learning/models/get_post_api.dart';
import 'package:api_learning/services/api_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<GetPostModel>>(
            future: apiServices.getPost(),
            builder: (context, snapshot) {
              final mainList = apiServices.getPostList;

              if (!snapshot.hasData || snapshot == null) {
                return CircularProgressIndicator(color: Colors.blue);
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: mainList.length,
                  itemBuilder: (context, index) {
                    final item = mainList[index];
                    return ListTile(
                      leading: Text(item.id.toString()),
                      title: Text(item.title.toString()),
                      subtitle: Text(item.body.toString()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
