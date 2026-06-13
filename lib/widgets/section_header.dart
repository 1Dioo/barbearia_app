/*
 * Widget utilizado para criar cabeçalhos de seções.
 *
 * Permite exibir um título principal e opcionalmente
 * uma ação adicional através de um botão de texto.
 */

import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (actionText.isNotEmpty)
          TextButton(
            onPressed: onTap,
            child: Text(actionText),
          ),
      ],
    );
  }
}
