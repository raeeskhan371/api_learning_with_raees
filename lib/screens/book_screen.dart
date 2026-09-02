import 'package:api_learning/services/get_book_api.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final GetBookApi apiServices = GetBookApi();

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
              child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 21),
            ),

            const SizedBox(width: 12),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Books",
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
        future: apiServices.getBooks(),
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
            return const Center(child: Text("No Books Found"));
          }

          final metaData = snapshot.data;
          final books = metaData?.books ?? [];

          // -------------------------------------------------------------
          // EMPTY
          // -------------------------------------------------------------

          if (books.isEmpty) {
            return const Center(child: Text("No Books Available"));
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
                  "Explore books fetched from the API.",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ),

              // =========================================================
              // TOTAL BOOKS
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
                      const Icon(Icons.library_books_outlined, size: 17),
                      const SizedBox(width: 7),
                      Text(
                        "${metaData?.total ?? books.length} Books",
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =========================================================
              // BOOK LIST
              // =========================================================
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final bookItem = books[index];

                    return _bookCard(
                      book: bookItem,
                      index: index,
                      onTap: () {
                        // Later:
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => BookDetailScreen(
                        //       book: bookItem,
                        //     ),
                        //   ),
                        // );
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
  // BOOK CARD
  // ===================================================================

  Widget _bookCard({required dynamic book, required int index, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // TOP ROW
            // =========================================================

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Icon

                Container(
                  height: 68,
                  width: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2FF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.menu_book_rounded, color: Color(0xFF4F46E5), size: 29),
                ),

                const SizedBox(width: 13),

                // Title + Author
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category

                      if (book.category != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F2FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            book.category.toString(),
                            style: const TextStyle(
                              color: Color(0xFF4F46E5),
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                      const SizedBox(height: 8),

                      // Title
                      Text(
                        book.title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.2,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Author
                      Row(
                        children: [
                          Icon(Icons.person_outline_rounded, size: 15, color: Colors.grey.shade500),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              book.author.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Number
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: const Color(0xFF202124), shape: BoxShape.circle),
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 17),

            // =========================================================
            // BOOK INFO
            // =========================================================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8FA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  // Published

                  Expanded(
                    child: _bookInfo(
                      icon: Icons.calendar_today_outlined,
                      label: "Published",
                      value: book.publishedYear.toString(),
                    ),
                  ),

                  Container(height: 32, width: 1, color: Colors.grey.shade300),

                  const SizedBox(width: 12),

                  // Created
                  Expanded(
                    child: _bookInfo(
                      icon: Icons.access_time_rounded,
                      label: "Created",
                      value: book.createdAt.toString(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // =========================================================
            // VIEW DETAILS
            // =========================================================
            Container(
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF202124),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View Book Details",
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
    );
  }

  // ===================================================================
  // BOOK INFO
  // ===================================================================

  Widget _bookInfo({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ],
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
