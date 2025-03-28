import 'package:blog_app/Core/Utils/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showlogoutdialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Logout',
    content: 'Are you sure you want to logout',
    optionsBuilder: () => {'Cancel': false, 'log out': true},
  ).then((value) => value ?? false);
}

           // previous code 
// Future<bool> showalertdialog(BuildContext context) {
//   return showDialog<bool>(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("Logout"),
//         content: const Text("Are you sure you want to logout ..."),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context, false);
//               },
//               child: const Text("cancel")),
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context, true);
//               },
//               child: const Text("Logout")),
//         ],
//       );
//     },
//   ).then((value) => value ?? false);
// }

