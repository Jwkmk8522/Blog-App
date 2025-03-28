part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class BlogUploadByUserEvent extends BlogEvent {
  final File image;
  final String title;
  final String description;
  final String posterId;
  final List<String> topics;
  BlogUploadByUserEvent({
    required this.image,
    required this.title,
    required this.description,
    required this.posterId,
    required this.topics,
  });
}

class FetchAllBlogs extends BlogEvent {}
