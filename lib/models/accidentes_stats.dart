class AccidentesStats {
  /// Distribución por clase de accidente
  final Map<String, int> porClase;

  /// Distribución por gravedad
  final Map<String, int> porGravedad;

  /// Top 5 barrios con más accidentes
  final Map<String, int> topBarrios;

  /// Distribución por día de la semana
  final Map<String, int> porDia;

  /// Total de registros procesados
  final int total;

  const AccidentesStats({
    required this.porClase,
    required this.porGravedad,
    required this.topBarrios,
    required this.porDia,
    required this.total,
  });
}
