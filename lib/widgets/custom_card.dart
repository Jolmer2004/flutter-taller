import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String route;
  final IconData? icon;
  final Color? color;
  final String? subtitle;

  const CustomCard({
    required this.title,
    required this.route,
    this.icon,
    this.color,
    this.subtitle,    super.key,  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppTheme.azul;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppTheme.superficie,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => context.go(route),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFE5E7EB), width: 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Icono con fondo coloreado
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon ?? Icons.folder_rounded,
                    color: cardColor,
                    size: 26,
                  ),
                ),
                SizedBox(width: 16),
                // Texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textoOscuro,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textoGris,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Flecha
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: cardColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
