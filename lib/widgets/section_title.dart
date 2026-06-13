/*
 * Widget responsável por exibir títulos padronizados
 * nas diferentes seções do aplicativo.
 *
 * Pode incluir uma ação opcional para navegação
 * ou visualização de conteúdo complementar.
 */

import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onTap;

  const SectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const Spacer(),
        if (actionText != null)
          TextButton(
            onPressed: onTap,
            child: Text(actionText!),
          ),
      ],
    );
  }
}
