import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_book.dart';
import '../models/book.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library Books'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          List<Book> books = docs
              .map((doc) =>
                  Book.fromMap(doc.data()! as Map<String, dynamic>, doc.id))
              .toList();

          if (books.isEmpty) return Center(child: Text('No books found'));

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return ListTile(
                title: Text(book.heading),
                subtitle: Text(
                    'Author: ${book.author}\nYear: ${book.year}\nEdition: ${book.edition}\nPrice: \$${book.price.toStringAsFixed(2)}'),
                trailing: Icon(
                    book.isAvailable ? Icons.check_circle : Icons.cancel,
                    color: book.isAvailable ? Colors.green : Colors.red),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddBookScreen())),
      ),
    );
  }
}
