import 'package:flutter/material.dart';
import 'package:passantic/ui/datosPasante.dart';
import 'package:passantic/ui/views/alejandra/estadoPasantia.dart';
import 'package:passantic/ui/views/alejandra/opcionesPosulacion.dart';
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
         children: [OpcionesPostulacion(title: 'Postulaciones',), ObservarPostulacion( title: 'Revisar postulaciones',),datosPasante(title: 'Perfil del pasante',)],
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
          icon: Icon(Icons.person_pin_circle),
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
