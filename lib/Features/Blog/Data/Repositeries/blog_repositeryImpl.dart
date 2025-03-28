import 'dart:io';

import 'package:blog_app/Core/Errors/exceptions.dart';
import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Core/Network/connection_cheker.dart';
import 'package:blog_app/Core/constants/constants.dart';
import 'package:blog_app/Features/Blog/Data/Data_Source/blog_localdatasource.dart';
import 'package:blog_app/Features/Blog/Data/Data_Source/blog_remotedatasource.dart';
import 'package:blog_app/Features/Blog/Data/Models/blog_modals.dart';
import 'package:blog_app/Features/Blog/Domain/Enteties/blog_enteties.dart';
import 'package:blog_app/Features/Blog/Domain/Repositeries/blog_repositery.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositeryimpl implements BlogRepositery {
  BlogRemotedatasource blogRemotedatasource;
  BlogLocalDataSource blogLocalDataSource;
  ConnectionCheker connectionCheker;

  BlogRepositeryimpl({
    required this.blogRemotedatasource,
    required this.blogLocalDataSource,
    required this.connectionCheker,
  });

  @override
  Future<Either<Failure, BlogEnteties>> uploadBlog({
    required File image,
    required String title,
    required String description,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if ((!await connectionCheker.isConnected)) {
        return left(Failure(Constants.noConnection));
      }
      BlogModals blogModals = BlogModals(
        id: Uuid().v1(),
        posterId: posterId,
        title: title,
        description: description,
        imageUrl: '',
        topic: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemotedatasource.uploadBlogImage(
        image: image,
        blog: blogModals,
      );
      blogModals = blogModals.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemotedatasource.uploadBlog(blogModals);
      return Right(uploadedBlog);
    } on ServerException catch (e) {
      // return Left(Failure(e.message));
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEnteties>>> getAllBlogs() async {
    try {
      if ((!await connectionCheker.isConnected)) {
        final b = blogLocalDataSource.getBlogFromHive();
        return right(b);
      }
      final blog = await blogRemotedatasource.getAllBlogs();
      blogLocalDataSource.uploadBlogToHive(blogs: blog);
      return Right(blog);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
