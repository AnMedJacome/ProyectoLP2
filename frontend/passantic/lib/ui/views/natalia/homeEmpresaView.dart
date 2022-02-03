import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';
import 'package:passantic/ui/views/andres/serviciosLista.dart';
import 'package:passantic/ui/views/natalia/empresaDatos.dart';
import 'package:passantic/ui/views/natalia/empresaMenu.dart';
import 'package:passantic/ui/views/natalia/homeEmpresa.dart';
import 'package:passantic/ui/views/natalia/puestoRegister.dart';

class HomeView extends StatefulWidget {
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
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
        children: [ServicioAndres(), RegisterPuestoview(), Settings()],
       
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
        BottomNavigationBarItem(icon: Icon(Icons.fiber_new_outlined), label: "Crear puesto"),
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
