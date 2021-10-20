import 'package:flutter/material.dart';

showDialogGeneric({context, titulo, message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(titulo),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fechar'),
        ),
      ],
    ),
  );
}
