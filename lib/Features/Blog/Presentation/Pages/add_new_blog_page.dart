import 'dart:io';

import 'package:blog_app/Core/Common/Cubits/AppUser/app_user_cubit.dart';
import 'package:blog_app/Core/Common/Widgets/loader.dart';
import 'package:blog_app/Core/Themes/app_pallate.dart';
import 'package:blog_app/Core/Utils/error_dialog.dart';
import 'package:blog_app/Core/Utils/image_pick.dart';
import 'package:blog_app/Core/constants/constants.dart';
import 'package:blog_app/Features/Auth/Presentation/bloc/auth_bloc.dart';
import 'package:blog_app/Features/Blog/Presentation/Pages/blog_page.dart';
import 'package:blog_app/Features/Blog/Presentation/Widgets/blog_editor.dart';
import 'package:blog_app/Features/Blog/Presentation/bloc/blog_bloc.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  List<String> selectedTopics = [];
  File? image;
  final formKey = GlobalKey<FormState>();
  void selectImage() async {
    final pickedImage = await imageSelected();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void _uploadBlog() {
    if (formKey.currentState!.validate() &&
        image != null &&
        selectedTopics.isNotEmpty) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
        BlogUploadByUserEvent(
          image: image!,
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          posterId: posterId,
          topics: selectedTopics,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _uploadBlog();
            },
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showerrordialog(context, state.message);
          } else if (state is BlogUploadSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BlogPage()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                          onTap: selectImage,
                          child: SizedBox(
                            height: 150,
                            width: width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(image!, fit: BoxFit.cover),
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            dashPattern: [10, 5],
                            color: AppPallate.whiteColor,
                            strokeWidth: 2,
                            child: Container(
                              height: height * 0.22,
                              width: width,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 40,
                                    color: AppPallate.whiteColor,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Select Your Image',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            Constants.topics
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }

                                        setState(() {});
                                      },
                                      child: Chip(
                                        label: Text(e),
                                        backgroundColor:
                                            selectedTopics.contains(e)
                                                ? AppPallate.gradient1
                                                : AppPallate.backgroundColor,
                                        side: BorderSide(
                                          color:
                                              selectedTopics.contains(e)
                                                  ? AppPallate.transparentColor
                                                  : AppPallate.borderColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    SizedBox(height: 30),
                    BlogEditor(
                      controller: titleController,
                      hinttext: 'Blog Title',
                    ),
                    SizedBox(height: 20),
                    BlogEditor(
                      controller: descriptionController,
                      hinttext: 'Blog Description',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
