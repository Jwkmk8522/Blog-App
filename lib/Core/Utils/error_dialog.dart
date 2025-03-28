import 'package:blog_app/Core/Utils/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showerrordialog(BuildContext context, String text) {
  return showGenericDialog<void>(
    context: context,
    title: 'An Error Accoured',
    content: text,
    optionsBuilder: () => {'ok': null},
  );
}

                //old code
// import 'package:flutter/material.dart';

// Future<void> showmessage(BuildContext context, String text) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("An error accured"),
//         content: Text(text),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("ok"))
//         ],
//       );
//     },
//   );
// }