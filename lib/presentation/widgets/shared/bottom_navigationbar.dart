import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  // funcion que decteta que boton se toco seguno su indice
  // y redireciona el usuario segun la opcion
  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
      default:
    }
  }

  int getActiveTab(BuildContext context) {
    final path = GoRouterState.of(context).location;

    switch (path) {
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: getActiveTab(context),
      onTap: (value) {
        onItemTapped(context, value);
        // value => 0,1,2 => seungo la catidad de items
      },
      selectedItemColor: colors.primary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded), label: 'Categories'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), label: 'Favorites'),
      ],
    );
  }
}
