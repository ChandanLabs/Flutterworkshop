import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String heading = '', title = '', author = '', year = '', edition = '';
  double price = 0;
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Book')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Heading'),
                validator: (val) => val!.isEmpty ? 'Enter book heading' : null,
                onSaved: (val) => heading = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (val) => val!.isEmpty ? 'Enter title' : null,
                onSaved: (val) => title = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Author'),
                validator: (val) => val!.isEmpty ? 'Enter author' : null,
                onSaved: (val) => author = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Year'),
                validator: (val) => val!.isEmpty ? 'Enter year' : null,
                onSaved: (val) => year = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Edition'),
                validator: (val) => val!.isEmpty ? 'Enter edition' : null,
                onSaved: (val) => edition = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (val) => val!.isEmpty ? 'Enter price' : null,
                onSaved: (val) => price = double.tryParse(val!) ?? 0,
              ),
              SwitchListTile(
                title: Text('Available'),
                value: isAvailable,
                onChanged: (val) {
                  setState(() {
                    isAvailable = val;
                  });
                },
              ),
              ElevatedButton(
                child: Text('Add Book'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Book book = Book(
                      heading: heading,
                      title: title,
                      author: author,
                      year: year,
                      edition: edition,
                      price: price,
                      isAvailable: isAvailable,
                    );
                    await FirebaseFirestore.instance
                        .collection('books')
                        .add(book.toMap());
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
