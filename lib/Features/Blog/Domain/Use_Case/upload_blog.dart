import 'dart:io';

import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Core/UseCAses/usecase.dart';
import 'package:blog_app/Features/Blog/Domain/Enteties/blog_enteties.dart';
import 'package:blog_app/Features/Blog/Domain/Repositeries/blog_repositery.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<BlogEnteties, UploadBlogParams> {
  BlogRepositery blogRepositery;
  UploadBlog({required this.blogRepositery});

  @override
  Future<Either<Failure, BlogEnteties>> call(UploadBlogParams params) async {
    return await blogRepositery.uploadBlog(
      image: params.image,
      title: params.title,
      description: params.description,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String description;
  final String posterId;
  final List<String> topics;
  UploadBlogParams({
    required this.image,
    required this.title,
    required this.description,
    required this.posterId,
    required this.topics,
  });
}
