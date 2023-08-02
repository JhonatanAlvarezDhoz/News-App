import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _ModelNavigate(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigate(),
      ),
    );
  }
}

class _Navigate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final modelNavigate = Provider.of<_ModelNavigate>(context);
    return BottomNavigationBar(
      currentIndex: modelNavigate.actualPage,
      onTap: (int i) => modelNavigate.actualPage = i,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Para ti"),
        BottomNavigationBarItem(
            icon: Icon(Icons.public_rounded), label: "Encabezados")
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final modelNavigate = Provider.of<_ModelNavigate>(context);
    return PageView(
      controller: modelNavigate.pageController,
      //physics:NeverSchollPhysyc() blockear la navegacion del page view
      physics: const BouncingScrollPhysics(),
      children: const <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _ModelNavigate with ChangeNotifier {
  int _actualPage = 0;
  final _pageController = PageController();

  int get actualPage => _actualPage;

  set actualPage(int value) {
    _actualPage = value;
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInBack,
    );
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
