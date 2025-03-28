import 'package:blog_app/Core/Common/Cubits/LogOut/logout_user_cubit.dart';
import 'package:blog_app/Core/Common/Widgets/loader.dart';
import 'package:blog_app/Core/Themes/app_pallate.dart';
import 'package:blog_app/Core/Utils/error_dialog.dart';
import 'package:blog_app/Core/Utils/logout_dialog.dart';

import 'package:blog_app/Features/Blog/Presentation/Pages/add_new_blog_page.dart';
import 'package:blog_app/Features/Blog/Presentation/Widgets/blog_card.dart';
import 'package:blog_app/Features/Blog/Presentation/bloc/blog_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(FetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => AddNewBlogPage()));
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final confirmed = await showlogoutdialog(context);
              if (confirmed) {
                context.read<LogoutUserCubit>().logOutUSer();
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showerrordialog(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blog.length,
              itemBuilder: (context, index) {
                final blog = state.blog[index];
                return BlogCard(
                  blog: blog,
                  color:
                      index % 3 == 0
                          ? AppPallate.gradient1
                          : index % 3 == 1
                          ? AppPallate.gradient2
                          : AppPallate.gradient3,
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
