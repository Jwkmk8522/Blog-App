import 'dart:io';

import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Features/Blog/Domain/Enteties/blog_enteties.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepositery {
  Future<Either<Failure, BlogEnteties>> uploadBlog({
    required File image,
    required String title,
    required String description,
    required String posterId,
    required List<String> topics,
  });
  Future<Either<Failure, List<BlogEnteties>>> getAllBlogs();
}
