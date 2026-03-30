import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_teste_1/app_scaffold.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaNomesPageState createState() => _ListaNomesPageState();
}

class _ListaNomesPageState extends State<ListaPage> {
  final nomeDigitado = TextEditingController();
  String? erro;

  List<String> nomes = ["Pessoa1", "Pessoa2", "Pessoa3"];

  void adicionarALista() {
    setState(() {
      if (nomeDigitado.text.isEmpty) {
        erro = "O campo não pode estar vazio!";
        return;
      }
      erro = null;
      nomes.add(nomeDigitado.text);
      nomeDigitado.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Lista nomes",
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 400,
              height: 370,
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: nomes.length,

                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.person_2),
                      title: Text("${nomes[index]}"),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            nomes.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            TextField(
              controller: nomeDigitado,
              decoration: InputDecoration(
                helperText: "Não deixe o campo vazio!",
                helperMaxLines: 2,
                errorText: erro,
                labelText: "Digite um nome para ser adicionado à lista!",
                errorMaxLines: 2,
                border: OutlineInputBorder(),
              ),
              maxLength: 50,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: adicionarALista,
                child: Text("ADICIONAR À LISTA"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 9, 175, 95),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
