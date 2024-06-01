import 'package:flutter/material.dart';
import 'package:library_management/book_repository.dart';
import 'package:library_management/model/book.dart';

class BookDetail extends StatefulWidget {
  final Book book;

  const BookDetail({super.key, required this.book});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  var bookRepository = BookRepository();
  Book updatedBook = const Book.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatedBook = widget.book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Yazar Adı: "),
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        updatedBook = updatedBook.copyWith(author: val);
                      });
                    },
                    initialValue: widget.book.author!,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Kitap Adı: "),
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        updatedBook = updatedBook.copyWith(name: val);
                      });
                    },
                    initialValue: widget.book.name!,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    bookRepository.removeBook(book: widget.book);
                  },
                  child: const Text("Kitabı Sil"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await bookRepository.saveBook(book: updatedBook);
                  },
                  child: const Text("Kitabı Güncelle"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
