import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/establecimiento.dart';
import '../services/establecimientos_service.dart';
import '../views/home_view.dart';
import '../views/accidentes/accidentes_view.dart';
import '../views/establecimientos/establecimientos_list_view.dart';
import '../views/establecimientos/establecimiento_detail_view.dart';
import '../views/establecimientos/establecimiento_form_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/accidentes',
      builder: (context, state) => const AccidentesView(),
    ),
    GoRoute(
      path: '/establecimientos',
      builder: (context, state) => const EstablecimientosListView(),
    ),
    GoRoute(
      path: '/establecimientos/nuevo',
      builder: (context, state) =>
          const EstablecimientoFormView(establecimiento: null),
    ),
    GoRoute(
      path: '/establecimientos/:id',
      builder: (context, state) {
        // CORRECCIÓN: blindar contra el valor literal "nuevo"
        final rawId = state.pathParameters['id'] ?? '';
        if (rawId == 'nuevo') {
          return const EstablecimientoFormView(establecimiento: null);
        }

        final est = state.extra;
        if (est is Establecimiento) {
          return EstablecimientoDetailView(establecimiento: est);
        }

        final id = int.tryParse(rawId);
        if (id == null) {
          return const Scaffold(
            body: Center(child: Text('ID inválido')),
          );
        }
        return _EstablecimientoLoader(id: id, editar: false);
      },
    ),
    GoRoute(
      path: '/establecimientos/:id/editar',
      builder: (context, state) {
        final rawId = state.pathParameters['id'] ?? '';
        final est = state.extra;
        if (est is Establecimiento) {
          return EstablecimientoFormView(establecimiento: est);
        }

        final id = int.tryParse(rawId);
        if (id == null) {
          return const Scaffold(
            body: Center(child: Text('ID inválido')),
          );
        }
        return _EstablecimientoLoader(id: id, editar: true);
      },
    ),
  ],
);

/// Carga un establecimiento por ID cuando no viene en `extra`
class _EstablecimientoLoader extends StatefulWidget {
  final int id;
  final bool editar;
  const _EstablecimientoLoader({required this.id, required this.editar});

  @override
  State<_EstablecimientoLoader> createState() => _EstablecimientoLoaderState();
}

class _EstablecimientoLoaderState extends State<_EstablecimientoLoader> {
  Establecimiento? _est;
  String? _error;

  @override
  void initState() {
    super.initState();
    EstablecimientosService().getOne(widget.id).then((e) {
      if (mounted) setState(() => _est = e);
    }).catchError((e) {
      if (mounted) setState(() => _error = e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(body: Center(child: Text('Error: $_error')));
    }
    if (_est == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (widget.editar) {
      return EstablecimientoFormView(establecimiento: _est);
    }
    return EstablecimientoDetailView(establecimiento: _est!);
  }
}