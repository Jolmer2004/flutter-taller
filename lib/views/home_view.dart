import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../themes/app_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Aeropuertos',
      'route': '/list/Airport',
      'icon': Icons.flight_takeoff_rounded,
      'color': Color(0xFF003893),
      'subtitle': 'Terminales aéreas del país',
    },
    {
      'title': 'Ciudades',
      'route': '/list/City',
      'icon': Icons.location_city_rounded,
      'color': Color(0xFF0057B8),
      'subtitle': 'Municipios y capitales',
    },
    {
      'title': 'Departamentos',
      'route': '/list/Department',
      'icon': Icons.map_rounded,
      'color': Color(0xFFCE1126),
      'subtitle': '32 departamentos de Colombia',
    },
    {
      'title': 'Turismo',
      'route': '/list/TouristicAttraction',
      'icon': Icons.photo_camera_rounded,
      'color': Color(0xFF8B0000),
      'subtitle': 'Atractivos turísticos',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppTheme.azul,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'API Colombia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    'Explora los datos del país',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF003893),
                          Color(0xFF001F5C),
                        ],
                      ),
                    ),
                  ),
                  // Franja amarilla decorativa
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.amarillo,
                            AppTheme.amarillo.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Elementos decorativos
                  Positioned(
                    right: -30,
                    top: 20,
                    child: Opacity(
                      opacity: 0.06,
                      child: Icon(
                        Icons.public_rounded,
                        size: 180,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'CATEGORÍAS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppTheme.textoGris,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = _categories[index];
                  return CustomCard(
                    title: cat['title'],
                    route: cat['route'],
                    icon: cat['icon'],
                    color: cat['color'],
                    subtitle: cat['subtitle'],
                  );
                },
                childCount: _categories.length,
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }
}
