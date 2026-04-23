import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final dynamic data;

  const CustomListTile({required this.title, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.superficie,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => context.push('/detail', extra: data),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE5E7EB), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textoOscuro,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.textoGris,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
