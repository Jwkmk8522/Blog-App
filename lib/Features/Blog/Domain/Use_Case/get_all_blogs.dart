import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Core/UseCAses/usecase.dart';
import 'package:blog_app/Features/Blog/Domain/Enteties/blog_enteties.dart';
import 'package:blog_app/Features/Blog/Domain/Repositeries/blog_repositery.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<BlogEnteties>, NoParams> {
  BlogRepositery blogRepositery;
  GetAllBlogs({required this.blogRepositery});
  @override
  Future<Either<Failure, List<BlogEnteties>>> call(NoParams params) async {
    return await blogRepositery.getAllBlogs();
  }
}
