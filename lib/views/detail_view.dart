import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';

class DetailView extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailView({required this.data, super.key});

  bool _isImageUrl(dynamic value) {
    if (value is! String) return false;
    final lower = value.toLowerCase();
    return (lower.startsWith('http://') || lower.startsWith('https://')) &&
        (lower.endsWith('.jpg') ||
            lower.endsWith('.jpeg') ||
            lower.endsWith('.png') ||
            lower.endsWith('.webp') ||
            lower.endsWith('.gif') ||
            lower.contains('/images/') ||
            lower.contains('image') ||
            lower.contains('photo') ||
            lower.contains('flag') ||
            lower.contains('coat'));
  }

  bool _isUrl(dynamic value) {
    if (value is! String) return false;
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.trim().isEmpty) return false;
    if (value is Map && value.isEmpty) return false;
    if (value is List && value.isEmpty) return false;
    return true;
  }

  String _formatValue(dynamic value) {
    if (value is Map<String, dynamic>) {
      // Si es un objeto anidado, muestra sus campos como "clave: valor"
      return value.entries
          .where((e) => _hasValue(e.value) && e.value is! Map && e.value is! List)
          .map((e) => '${_formatKey(e.key)}: ${e.value}')
          .join('\n');
    }
    if (value is List) {
      return value.map((e) => e is Map ? (e['name'] ?? e.toString()) : e.toString()).join(', ');
    }
    return value.toString();
  }

  String _formatKey(String key) {
    return key
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (m) => ' ${m.group(0)}',
        )
        .trim()
        .toLowerCase()
        .split(' ')
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() + w.substring(1) : w)
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final imageEntries = data.entries
        .where((e) => _isImageUrl(e.value) && _hasValue(e.value))
        .toList();
    final textEntries = data.entries
        .where((e) => !_isImageUrl(e.value) && _hasValue(e.value))
        .toList();

    final displayName = data['name']?.toString() ??
        data['Name']?.toString() ??
        'Detalle';

    return Scaffold(
      backgroundColor: AppTheme.fondo,
      appBar: AppBar(
        title: Text(
          displayName,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: AppTheme.azul,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          tooltip: 'Volver',
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          if (imageEntries.isNotEmpty) ...[
            ...imageEntries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionLabel(label: _formatKey(entry.key)),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          entry.value,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(0xFFE5E7EB),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                'Imagen no disponible',
                                style: TextStyle(color: AppTheme.textoGris),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 8),
          ],

          if (textEntries.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: AppTheme.superficie,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFE5E7EB), width: 1),
              ),
              child: Column(
                children: textEntries.asMap().entries.map((mapEntry) {
                  final idx = mapEntry.key;
                  final entry = mapEntry.value;
                  final isLast = idx == textEntries.length - 1;
                  final value = entry.value;
                  final formattedValue = _formatValue(value);

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Text(
                                _formatKey(entry.key),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textoGris,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _isUrl(value)
                                  ? Row(
                                      children: [
                                        Icon(Icons.link_rounded,
                                            size: 14,
                                            color: AppTheme.azul),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            value.toString(),
                                            style: TextStyle(
                                              color: AppTheme.azul,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      formattedValue,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.textoOscuro,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: Color(0xFFE5E7EB),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),

          SizedBox(height: 28),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back_rounded, size: 18),
                  label: Text('Volver'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.azul,
                    side: BorderSide(color: AppTheme.azul, width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/'),
                  icon: Icon(Icons.home_rounded, size: 18),
                  label: Text('Inicio'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.azul,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 13),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: AppTheme.textoGris,
      ),
    );
  }
}