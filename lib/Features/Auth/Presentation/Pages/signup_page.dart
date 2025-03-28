import 'package:blog_app/Core/Common/Widgets/loader.dart';
import 'package:blog_app/Core/Themes/app_pallate.dart';
import 'package:blog_app/Core/Utils/show_snackbar.dart';
import 'package:blog_app/Features/Auth/Presentation/Pages/signin_page.dart';
import 'package:blog_app/Features/Auth/Presentation/Widgets/auth_feilds.dart';
import 'package:blog_app/Features/Auth/Presentation/Widgets/auth_gradient_button.dart';
import 'package:blog_app/Features/Auth/Presentation/bloc/auth_bloc.dart';
import 'package:blog_app/Features/Blog/Presentation/Pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            return showSnackbar(context, state.message);
          }
          if (state is AuthSuccess) {
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
          return Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up .',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 30),
                    AuthFeilds(hint: 'Name', controller: nameController),
                    SizedBox(height: 15),
                    AuthFeilds(hint: 'Email', controller: emailController),
                    SizedBox(height: 15),
                    AuthFeilds(
                      hint: 'Password',
                      controller: passwordController,
                      isVisible: isVisible,
                      visibilityIcon:
                          isVisible ? Icons.visibility_off : Icons.visibility,
                      callback: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    AuthGradientButton(
                      textt: 'Sign Up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // print("Sign Up Button Pressed");
                          // print("Name: ${nameController.text.trim()}");
                          // print("Email: ${emailController.text.trim()}");
                          // print("Password: ${passwordController.text.trim()}");

                          context.read<AuthBloc>().add(
                            SignedUpButonPressed(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already Have An Account'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SigninPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: AppPallate.gradient2),
                          ),
                        ),
                      ],
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
