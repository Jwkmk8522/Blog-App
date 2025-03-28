import 'package:blog_app/Core/Utils/calculate_reading_time.dart';
import 'package:blog_app/Features/Blog/Domain/Enteties/blog_enteties.dart';
import 'package:blog_app/Features/Blog/Presentation/Pages/blog_view.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogEnteties blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => BlogView(blog: blog)));
      },
      child: Container(
        margin: EdgeInsets.all(16).copyWith(bottom: 3),
        padding: EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        blog.topic
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Chip(label: Text(e)),
                              ),
                            )
                            .toList(),
                  ),
                ),
                Text(blog.title, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),

            // Text(blog.description),
            Text('${calculateReadingTime(blog.description)}Min'),
          ],
        ),
      ),
    );
  }
}
