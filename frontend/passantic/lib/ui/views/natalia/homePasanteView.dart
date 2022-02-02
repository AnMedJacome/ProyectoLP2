import 'package:flutter/material.dart';
import 'package:passantic/ui/views/natalia/empresaMenu.dart';
import 'package:passantic/ui/views/natalia/pasanteMenu.dart';

class HomePasanteView extends StatefulWidget {
  _HomePasanteView createState() => _HomePasanteView();
}

class _HomePasanteView extends State<HomePasanteView> {
  int _currentPage = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(),
      body: PageView(
        controller: _pageController,
        children: [MenuPasante(), Text("Opcion aun no implementada"), Text("Opcion aun no implementada")],
        onPageChanged: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }

  BottomNavigationBar _bottomBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Inicio",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Mensajería"),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Perfil",
        ),
      ],
      onTap: (int index) {
        setState(() {
          _currentPage = index;
          _pageController!.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        });
      },
    );
  }
}
