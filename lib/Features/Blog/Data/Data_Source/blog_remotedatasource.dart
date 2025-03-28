import 'dart:io';

import 'package:blog_app/Core/Errors/exceptions.dart';
import 'package:blog_app/Features/Blog/Data/Models/blog_modals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemotedatasource {
  Future<BlogModals> uploadBlog(BlogModals blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModals blog,
  });
  Future<List<BlogModals>> getAllBlogs();
}

class BlocRemotedatasoursceImpl implements BlogRemotedatasource {
  final SupabaseClient supabaseClient;
  BlocRemotedatasoursceImpl({required this.supabaseClient});
  @override
  Future<BlogModals> uploadBlog(BlogModals blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.tojson()).select();
      return BlogModals.fromjson(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModals blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_Images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_Images').getPublicUrl(blog.id);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModals>> getAllBlogs() async {
    try {
      final blog = await supabaseClient
          .from('blogs')
          .select('* , profiles (name)');
      return blog
          .map(
            (blog) => BlogModals.fromjson(
              blog,
            ).copyWith(posterName: blog['profiles']['name']),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
