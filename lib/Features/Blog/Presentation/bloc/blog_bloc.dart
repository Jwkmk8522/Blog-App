import 'dart:io';

import 'package:blog_app/Core/UseCAses/usecase.dart';
import 'package:blog_app/Features/Blog/Domain/Enteties/blog_enteties.dart';
import 'package:blog_app/Features/Blog/Domain/Use_Case/get_all_blogs.dart';
import 'package:blog_app/Features/Blog/Domain/Use_Case/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlog;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlog})
    : _uploadBlog = uploadBlog,
      _getAllBlog = getAllBlog,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => (emit(BlogLoading())));
    on<BlogUploadByUserEvent>(_onBlogUploadByUserEvent);
    on<FetchAllBlogs>(_onFetchAllBlogs);
  }
  void _onBlogUploadByUserEvent(
    BlogUploadByUserEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        description: event.description,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (l) => emit(BlogUploadSuccess()),
    );
  }

  void _onFetchAllBlogs(FetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlog(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
