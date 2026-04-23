import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../config/env.dart';
import '../models/accidente.dart';
import '../models/accidentes_stats.dart';

class AccidentesService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    headers: {'Accept': 'application/json'},
  ));

  Future<List<Accidente>> fetchAccidentes() async {
    try {
      final url = '${Env.baseUrl}/ezt8-5wyj.json';
      print('Solicitando accidentes desde: $url');

      final response = await _dio.get<dynamic>(
        url,
        queryParameters: {'\$limit': '100000'},
      );

      final data = response.data;
      final List<dynamic> lista = data is List ? data : [];

      print('✓ ${lista.length} accidentes obtenidos');
      return lista
          .map((e) => Accidente.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      print('✗ Error en AccidentesService: ${e.message}');
      print('   Tipo: ${e.type}');
      throw Exception('Error al obtener accidentes: ${e.message}');
    } catch (e) {
      print('✗ Error inesperado: $e');
      throw Exception('Error inesperado: $e');
    }
  }

  Future<AccidentesStats> computeStats(List<Accidente> accidentes) async {
    print('Iniciando procesamiento con compute()...');
    try {
      return await compute(_calcularStats, accidentes);
    } catch (e) {
      print('Fallback al hilo principal: $e');
      return _calcularStats(accidentes);
    }
  }
}


AccidentesStats _calcularStats(List<Accidente> accidentes) {
  final startMs = DateTime.now().millisecondsSinceEpoch;
  print('[Isolate] Iniciado — ${accidentes.length} registros recibidos');

  final porClase = <String, int>{};
  final porGravedad = <String, int>{};
  final porBarrio = <String, int>{};
  final porDia = <String, int>{};

  for (final a in accidentes) {
    final clase = _normalizarClase(a.claseAccidente);
    porClase[clase] = (porClase[clase] ?? 0) + 1;

    final gravedad = _normalizarGravedad(a.gravedadAccidente);
    porGravedad[gravedad] = (porGravedad[gravedad] ?? 0) + 1;

    final barrio = a.barrioHecho.isNotEmpty ? a.barrioHecho : 'Desconocido';
    porBarrio[barrio] = (porBarrio[barrio] ?? 0) + 1;

    final dia = _normalizarDia(a.dia);
    porDia[dia] = (porDia[dia] ?? 0) + 1;
  }

  // Top 5 barrios
  final sortedBarrios = porBarrio.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  final topBarrios = Map.fromEntries(sortedBarrios.take(5));

  // Ordenar días de la semana
  final diasOrden = [
    'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo',
  ];
  final porDiaOrdenado = <String, int>{};
  for (final d in diasOrden) {
    if (porDia.containsKey(d)) porDiaOrdenado[d] = porDia[d]!;
  }
  for (final entry in porDia.entries) {
    if (!porDiaOrdenado.containsKey(entry.key)) {
      porDiaOrdenado[entry.key] = entry.value;
    }
  }

  final elapsedMs = DateTime.now().millisecondsSinceEpoch - startMs;
  print('[Isolate] Completado en $elapsedMs ms');

  return AccidentesStats(
    porClase: porClase,
    porGravedad: porGravedad,
    topBarrios: topBarrios,
    porDia: porDiaOrdenado,
    total: accidentes.length,
  );
}

String _normalizarClase(String clase) {
  final lower = clase.toLowerCase();
  if (lower.contains('choque')) return 'Choque';
  if (lower.contains('atropello')) return 'Atropello';
  if (lower.contains('volcamiento')) return 'Volcamiento';
  if (lower.contains('caida') || lower.contains('caída')) return 'Caída';
  return 'Otro';
}

String _normalizarGravedad(String gravedad) {
  final lower = gravedad.toLowerCase();
  if (lower.contains('muerto') || lower.contains('fatal')) return 'Con muertos';
  if (lower.contains('herido')) return 'Con heridos';
  if (lower.contains('daño') || lower.contains('dano')) return 'Solo daños';
  return gravedad.isNotEmpty ? gravedad : 'Desconocido';
}

String _normalizarDia(String dia) {
  final lower = dia.toLowerCase().trim();
  const mapa = {
    'lunes': 'Lunes',
    'martes': 'Martes',
    'miercoles': 'Miercoles',
    'miércoles': 'Miercoles',
    'jueves': 'Jueves',
    'viernes': 'Viernes',
    'sabado': 'Sabado',
    'sábado': 'Sabado',
    'domingo': 'Domingo',
  };
  return mapa[lower] ?? dia;
}