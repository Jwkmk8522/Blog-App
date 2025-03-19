import 'package:blog_app/Core/Common/Widgets/loader.dart';
import 'package:blog_app/Core/Themes/app_pallate.dart';
import 'package:blog_app/Core/Utils/show_snackbar.dart';
import 'package:blog_app/Features/Auth/Presentation/Pages/signup_page.dart';
import 'package:blog_app/Features/Auth/Presentation/Widgets/auth_feilds.dart';
import 'package:blog_app/Features/Auth/Presentation/Widgets/auth_gradient_button.dart';
import 'package:blog_app/Features/Auth/Presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  void dispose() {
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
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Loader();
          }
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In .',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 30),

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
                  textt: 'Sign In',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        LogedInButonPressed(
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
                    Text('Does Not Have An Acoount ?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppPallate.gradient2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
