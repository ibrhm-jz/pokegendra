import 'package:flutter/material.dart';

class DialogAddTeam extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController controller;

  const DialogAddTeam({
    Key? key,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: 'Nombre del equipo'),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text("Crear equipo"),
        ),
      ],
    );
  }
}
