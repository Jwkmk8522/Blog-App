import 'package:blog_app/Core/Utils/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showdeletedialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to Delete this note?',
    optionsBuilder: () => {'Cancel': false, 'Delete': true},
  ).then((value) => value ?? false);
}
