class Book {
  final String? id;
  final String? name;
  final String? author;
  final DateTime? date;

  Book copyWith({
    String? id,
    String? name,
    String? author,
    DateTime? date,
  }) {
    return Book(id: id ?? this.id, name: name ?? this.name, author: author ?? this.author, date: date ?? this.date);
  }

  const Book({this.id, this.name, this.author, this.date});

  const Book.empty()
      : id = null,
        name = null,
        author = 'tr',
        date = null;

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      date: json['date'] != null ? (json['date']).toDate() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'author': author,
        'date': date,
      };
}
