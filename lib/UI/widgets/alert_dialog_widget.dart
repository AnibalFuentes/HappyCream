import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final List<Widget> contentWidgets;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const AlertDialogWidget({
    Key? key,
    required this.title,
    required this.contentWidgets,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contentWidgets,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
