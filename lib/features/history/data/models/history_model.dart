class HistoryNoteModel {
  final int id;
  final String title;
  final String description;

  HistoryNoteModel({
    required this.id,
    required this.title,
    required this.description,
  });

  // Factory constructor to create a Note instance from a Map
  factory HistoryNoteModel.fromMap(Map<String, dynamic> map) {
    return HistoryNoteModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  // Method to convert a Note instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
