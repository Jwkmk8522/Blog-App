class BlogEnteties {
  final String id;
  final String posterId;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> topic;
  final DateTime updatedAt;
  final String? posterName;

  BlogEnteties({
    required this.id,
    required this.posterId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.topic,
    required this.updatedAt,
    this.posterName,
  });
}
