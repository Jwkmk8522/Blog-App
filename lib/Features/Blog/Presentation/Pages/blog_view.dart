import 'package:blog_app/Core/Utils/calculate_reading_time.dart';
import 'package:blog_app/Core/Utils/date_format.dart';
import 'package:blog_app/Features/Blog/Domain/Enteties/blog_enteties.dart';
import 'package:flutter/material.dart';

class BlogView extends StatelessWidget {
  final BlogEnteties blog;
  const BlogView({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 20),
                Text(
                  'By ${blog.posterName}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: 5),
                Text(
                  '${dateFormatDMMMYYYY(blog.updatedAt)}.  ${calculateReadingTime(blog.description)} Min',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
                SizedBox(height: 20),
                Text(
                  blog.description,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
