import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../themes/app_theme.dart';
import 'package:go_router/go_router.dart';

class ListViewScreen extends StatefulWidget {
  final String endpoint;

  const ListViewScreen({required this.endpoint, super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  late Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService().getData(widget.endpoint);
  }

  String get _endpoint => widget.endpoint;

  String get _displayTitle {
    switch (_endpoint) {
      case 'Airport':
        return 'Aeropuertos';
      case 'City':
        return 'Ciudades';
      case 'Department':
        return 'Departamentos';
      case 'TouristicAttraction':
        return 'Turismo';
      default:
        return _endpoint;
    }
  }

  IconData get _endpointIcon {
    switch (_endpoint) {
      case 'Airport':
        return Icons.flight_takeoff_rounded;
      case 'City':
        return Icons.location_city_rounded;
      case 'Department':
        return Icons.map_rounded;
      case 'TouristicAttraction':
        return Icons.photo_camera_rounded;
      default:
        return Icons.list_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      appBar: AppBar(
        title: Text(_displayTitle),
        backgroundColor: AppTheme.azul,
        // Botón de volver
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          tooltip: 'Volver',
          onPressed: () => context.go('/'),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppTheme.azul,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Cargando datos...',
                    style: TextStyle(
                      color: AppTheme.textoGris,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off_rounded,
                        size: 56, color: Colors.red.shade300),
                    SizedBox(height: 16),
                    Text(
                      'Error al cargar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textoOscuro,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.textoGris, fontSize: 13),
                    ),
                    SizedBox(height: 24),
                    // Botón de volver en estado de error
                    _BackButton(onPressed: () => context.go('/')),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_rounded,
                      size: 56, color: AppTheme.textoGris),
                  SizedBox(height: 16),
                  Text(
                    'Sin resultados',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textoOscuro,
                    ),
                  ),
                  SizedBox(height: 24),
                  _BackButton(onPressed: () => context.go('/')),
                ],
              ),
            );
          }

          final data = snapshot.data!;

          return Column(
            children: [
              // Contador de resultados
              Container(
                color: AppTheme.superficie,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Icon(_endpointIcon, size: 16, color: AppTheme.azul),
                    SizedBox(width: 8),
                    Text(
                      '${data.length} resultados',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textoGris,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  itemCount: data.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = data[index] as Map<String, dynamic>;
                    return Material(
                      color: AppTheme.superficie,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => context.push('/detail', extra: item),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Color(0xFFE5E7EB), width: 1),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppTheme.azul.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.azul,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  item['name']?.toString() ?? 'Sin nombre',
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
                  },
                ),
              ),
            ],
          );
        },
      ),
      // Botón flotante de volver
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/'),
        backgroundColor: AppTheme.azul,
        foregroundColor: Colors.white,
        icon: Icon(Icons.home_rounded, size: 20),
        label: Text(
          'Inicio',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      ),
    );
  }
}

// Widget reutilizable de botón volver
class _BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _BackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.arrow_back_rounded, size: 18),
      label: Text('Volver al inicio'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.azul,
        side: BorderSide(color: AppTheme.azul),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
