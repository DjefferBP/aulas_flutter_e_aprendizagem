import 'package:app_teste_1/main.dart';
import 'package:flutter/material.dart';
import 'package:app_teste_1/exercicios_base/LoginPage.dart';
import 'package:app_teste_1/exercicios_base/ToDoSimplespage.dart';
import 'package:app_teste_1/exercicios_base/lista_nomes_page.dart';
import 'package:app_teste_1/exercicios_base/segundo_exercicio.dart';
import 'package:app_teste_1/exercicios_base/ListaDeComprasToDoPage.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;

  const AppScaffold({
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    final apps = [
      {"nome": "Home", "pagina": MyApp(), "icon": Icons.home},
      {
        "nome": "Validação de texto",
        "pagina": Exercicio2(),
        "icon": Icons.text_fields,
      },
      {"nome": "Lista de nomes", "pagina": ListaPage(), "icon": Icons.list},
      {"nome": "Login", "pagina": LoginPageUser(), "icon": Icons.login},
      {"nome": "ToDo", "pagina": TodosimplesPage(), "icon": Icons.check},
      {
        "nome": "Compras",
        "pagina": ListaDeComprasPage(),
        "icon": Icons.shopping_cart,
      },
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(title)),

      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "Meus Projetos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ...apps.map((app) {
              return ListTile(
                leading: Icon(app["icon"] as IconData),
                title: Text(app["nome"] as String),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => app["pagina"] as Widget),
                  );
                },
              );
            }),
          ],
        ),
      ),

      body: body,
    );
  }
}
