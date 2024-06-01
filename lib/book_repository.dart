import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_management/model/book.dart';

class BookRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Book>?> getAllBooksList() async {
    try {
      CollectionReference collectionReference = _firestore.collection('books');
      QuerySnapshot snapshot = await collectionReference.get();
      List<QueryDocumentSnapshot> documents = snapshot.docs;
      List<Book> bookList = [];
      for (QueryDocumentSnapshot document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        bookList.add(Book.fromJson(data));
      }
      return bookList;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<void> saveBook({required Book book}) async {
    try {
      final result = await _firestore.runTransaction((transaction) async {
        final roundsCollection = _firestore.collection('books');
        final documentRef = book.id == null
            ? roundsCollection.doc()
            : roundsCollection.doc(book.id);
        if (book.id == null) {
          final documentUuid = documentRef.id;
          book = book.copyWith(
            id: documentUuid,
          );
          transaction.set(documentRef, book.toJson());
        } else {
          var newDocumentRef =
              FirebaseFirestore.instance.collection('books').doc(book.id);
          transaction.update(newDocumentRef, book.toJson());
        }
        return;
      });

      return result;
    } on FirebaseException catch (e) {
      return;
    }
  }

  Future<void> removeBook({required Book book}) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('books').doc(book.id);
    try {
      await documentReference.delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
