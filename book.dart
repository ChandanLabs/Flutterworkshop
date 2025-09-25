class Book {
  String id;
  String title;
  String author;
  String year;
  String edition;
  double price;
  String heading;
  bool isAvailable;

  Book({
    this.id = '',
    required this.title,
    required this.author,
    required this.year,
    required this.edition,
    required this.price,
    required this.heading,
    this.isAvailable = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'year': year,
      'edition': edition,
      'price': price,
      'heading': heading,
      'isAvailable': isAvailable,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map, String id) {
    return Book(
      id: id,
      title: map['title'],
      author: map['author'],
      year: map['year'],
      edition: map['edition'],
      price: map['price'],
      heading: map['heading'],
      isAvailable: map['isAvailable'],
    );
  }
}
