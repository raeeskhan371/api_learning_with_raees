import 'package:api_learning/services/get_book_api.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final GetBookApi apiServices = GetBookApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder(
        future: apiServices.getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No Data"));
          }
          final metaData = snapshot.data;
          final books = metaData?.books ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Books:${metaData!.total.toString()}"),
              Text(""),
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final bookItem = books[index];

                    return ListTile(
                      leading: Icon(Icons.book),
                      title: Text(bookItem.title.toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bookItem.author.toString()),
                          Text(bookItem.createdAt.toString()),
                          Text(bookItem.publishedYear.toString()),
                          Text(bookItem.category.toString()),
                        ],
                      ),
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
}
