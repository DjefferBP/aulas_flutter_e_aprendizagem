import 'package:flutter/material.dart';
import 'package:app_teste_1/app_scaffold.dart';

class Exercicio2 extends StatefulWidget {
  @override
  _Exercicio2State createState() => _Exercicio2State();
}

class _Exercicio2State extends State<Exercicio2> {
  final textoDigitado = TextEditingController();
  int total_digitado = 0;
  String texto = "Digite algo!";
  String? erro;

  Color corTexto() {
    if (textoDigitado.text.isEmpty) {
      return Colors.red;
    } else if (textoDigitado.text.length > 15) {
      return Colors.orange;
    } else {
      return Colors.black;
    }
  }

  bool isVazio() {
    return textoDigitado.text.length == 0;
  }

  void enviarTexto() {
    setState(() {
      if (textoDigitado.text.isEmpty) {
        erro = "Não pode enviar texto vazio!!";
        return;
      }
      erro = null;
      texto = textoDigitado.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Validação de texto",
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(texto, style: TextStyle(color: corTexto(), fontSize: 18)),
            SizedBox(height: 15),
            TextField(
              controller: textoDigitado,
              decoration: InputDecoration(
                labelText: "Digite algo",
                errorText: erro,
                border: OutlineInputBorder(),
              ),
              maxLength: 20,
              onChanged: (value) {
                setState(() {
                  total_digitado = textoDigitado.text.length;
                });
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: enviarTexto,
                child: Text("ENVIAR TEXTO"),
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
