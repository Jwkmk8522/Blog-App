import 'package:blog_app/Core/Themes/app_pallate.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String textt;
  final VoidCallback onPressed;
  const AuthGradientButton({
    super.key,
    required this.textt,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppPallate.gradient1, AppPallate.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          fixedSize: Size(375, 50),
          backgroundColor: AppPallate.transparentColor,
          shadowColor: AppPallate.transparentColor,
        ),
        child: Text(textt, style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
