import 'package:blog_app/Features/Blog/Domain/Enteties/blog_enteties.dart';

class BlogModals extends BlogEnteties {
  BlogModals({
    required super.id,
    required super.posterId,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.topic,
    required super.updatedAt,
    super.posterName,
  });

  BlogModals copyWith({
    String? id,
    String? posterId,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? topic,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModals(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      topic: topic ?? this.topic,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }

  // Convert BlogEntities to a Map
  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'poster_id': posterId,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'topic': topic,
      'updated_at': updatedAt.toIso8601String(), // Convert DateTime to String
    };
  }

  // Create BlogEntities from a Map
  static BlogModals fromjson(Map<String, dynamic> map) {
    return BlogModals(
      id: map['id'],
      posterId: map['poster_id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['image_url'],
      topic: List<String>.from(map['topic']),
      updatedAt:
          map['updated_at'] == null
              ? DateTime.now()
              : DateTime.parse(map['updated_at']), // Convert String to DateTime
    );
  }
}
