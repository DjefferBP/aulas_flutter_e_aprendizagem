import 'package:flutter/material.dart';
import 'package:app_teste_1/app_scaffold.dart';
import 'package:app_teste_1/exercicios_base/ListaDeComprasToDoPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainHubPage());
  }
}

class MainHubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Apps",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bem-vindo \nEscolhe um projeto no menu",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ListaDeComprasPage()),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              label: Text(
                "Ir para Lista de Compras",
                style: TextStyle(color: Colors.black45),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
