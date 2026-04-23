class Establecimiento {
  final int? id;
  final String nombre;
  final String nit;
  final String direccion;
  final String telefono;
  final String? logoUrl;

  const Establecimiento({
    this.id,
    required this.nombre,
    required this.nit,
    required this.direccion,
    required this.telefono,
    this.logoUrl,
  });

  factory Establecimiento.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final int? parsedId = rawId is int
        ? rawId
        : rawId != null
            ? int.tryParse(rawId.toString())
            : null;

    final String nombre = _getFieldValue(json, [
      'nombre', 'name', 'titulo', 'establishment_name', 'establecimiento',
      'razon_social', 'razonSocial', 'nombre_establecimiento',
    ]);
    final String nit = _getFieldValue(json, [
      'nit', 'tax_id', 'documento', 'document', 'ruc',
      'numero_documento', 'identificacion',
    ]);
    final String direccion = _getFieldValue(json, [
      'direccion', 'address', 'location', 'domicilio', 'sede',
      'dir', 'ubicacion', 'lugar',
    ]);
    final String telefono = _getFieldValue(json, [
      'telefono', 'phone', 'tel', 'celular', 'contact',
      'numero', 'contacto', 'telephone', 'mobile',
    ]);
    final String? logo = _getFieldValueNullable(json, [
      'logo', 'logoUrl', 'logo_url', 'image', 'imagen', 'foto',
      'avatar', 'picture', 'img',
    ]);

    print('📦 fromJson - Keys: ${json.keys.toList()}');
    print('   → nombre: "$nombre", nit: "$nit", id: $parsedId');

    return Establecimiento(
      id: parsedId,
      nombre: nombre.isNotEmpty ? nombre : 'Sin nombre',
      nit: nit.isNotEmpty ? nit : 'N/A',
      direccion: direccion.isNotEmpty ? direccion : 'Sin dirección',
      telefono: telefono.isNotEmpty ? telefono : 'N/A',
      logoUrl: logo?.isNotEmpty == true ? logo : null,
    );
  }

  static String _getFieldValue(Map<String, dynamic> json, List<String> possibleKeys) {
    for (final key in possibleKeys) {
      if (json.containsKey(key) && json[key] != null) {
        return json[key].toString().trim();
      }
    }
    return '';
  }

  static String? _getFieldValueNullable(Map<String, dynamic> json, List<String> possibleKeys) {
    for (final key in possibleKeys) {
      if (json.containsKey(key) && json[key] != null) {
        final value = json[key].toString().trim();
        return value.isEmpty ? null : value;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'nit': nit,
        'direccion': direccion,
        'telefono': telefono,
      };
}