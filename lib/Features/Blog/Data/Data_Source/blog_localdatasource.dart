import 'package:blog_app/Features/Blog/Data/Models/blog_modals.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadBlogToHive({required List<BlogModals> blogs});
  List<BlogModals> getBlogFromHive();
}

class BlogLocaldatasourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocaldatasourceImpl({required this.box});
  @override
  List<BlogModals> getBlogFromHive() {
    List<BlogModals> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModals.fromjson(box.get(i.toString())));
      }
    });
    return blogs;
  }

  @override
  void uploadBlogToHive({required List<BlogModals> blogs}) {
    box.clear();
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].tojson());
      }
    });
  }
}
