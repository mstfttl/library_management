import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_management/book_detail.dart';
import 'package:library_management/book_repository.dart';
import 'package:library_management/model/book.dart';
import 'package:library_management/util/util.dart';
import 'add_student.dart';
import 'student_list.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kütüphane',
      home: const BookList(),
    );
  }
}

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  var bookRepository = BookRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Kitap Listesi"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Kitap Listesi'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),

            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Öğrenci Ekleme'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddStudent()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Öğrenci Listesi'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentListPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          List<Book> bookList = [];
          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              final Map<String, dynamic> data =
              doc.data() as Map<String, dynamic>;
              final Book book = Book.fromJson(data);
              bookList.add(book);
            }
          }
          return ListView.builder(
            itemCount: bookList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookDetail(book: bookList[index]),
                        ),
                      );
                    },
                    title: Text(bookList[index].name!),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController nameController = TextEditingController();
          TextEditingController authorController = TextEditingController();
          int day = 1;
          int month = 1;
          int year = 2024;

          showDialog(
            context: context,
            builder: (dialogContext) => CustomDialog(
              contentWidget: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                      decoration:
                      CommonDecorations.whiteTextFieldDecoration(),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: CommonDecorations.commonLoginDecoration(
                            'Kitap Adı'),
                        textAlign: TextAlign.left,
                        cursorColor: ColorConstants.bbTwoFive,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                      decoration:
                      CommonDecorations.whiteTextFieldDecoration(),
                      child: TextFormField(
                        controller: authorController,
                        keyboardType: TextInputType.text,
                        decoration: CommonDecorations.commonLoginDecoration(
                            'Yazarı'),
                        textAlign: TextAlign.left,
                        cursorColor: ColorConstants.bbTwoFive,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownDatePicker(
                    isFormValidator: true,
                    onChangedDay: (value) {
                      value != null ? day = int.tryParse(value)! : day = 1;
                    },
                    onChangedMonth: (value) {
                      value != null ? month = int.tryParse(value)! : month = 1;
                    },
                    onChangedYear: (value) {
                      value != null
                          ? year = int.tryParse(value)!
                          : year = 2024;
                    },
                    inputDecoration:
                    const InputDecoration(border: InputBorder.none),
                    boxDecoration:
                    CommonDecorations.commonTextFieldDecoration(),
                    dayFlex: 3,
                    monthFlex: 4,
                    yearFlex: 4,
                  ),
                  const SizedBox(height: 32),
                  InkWell(
                    onTap: () async {
                      Book book = Book(
                        author: authorController.text,
                        name: nameController.text,
                        date: DateTime(year, month, day),
                      );
                      await bookRepository.saveBook(book: book);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [
                            ColorConstants.bbTwoFive,
                            ColorConstants.fiveFiveOneOne,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: const [0, 1],
                        ),
                      ),
                      child: const Center(
                        child: Text('Kaydet'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
