import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_teste_1/app_scaffold.dart';
import 'package:app_teste_1/class/tarefa.dart';

class TodosimplesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Todosimples());
  }
}

class Todosimples extends StatefulWidget {
  @override
  _TodosimplesPageState createState() => _TodosimplesPageState();
}

class _TodosimplesPageState extends State<Todosimples> {
  final tarefaDigitada = TextEditingController();
  String? erro;

  List<Tarefa> tarefas = [];

  List<bool> valores_bool = [true, false];

  void adicionarALista() {
    setState(() {
      if (tarefaDigitada.text.isEmpty) {
        erro = "O campo não pode estar vazio!";
        return;
      }
      erro = null;
      Tarefa tf = new Tarefa(nome: tarefaDigitada.text);
      tarefas.add(tf);
      tarefaDigitada.text = "";
    });
  }

  void editarTarefa({required Tarefa tarefa}) {
    TextEditingController editarController = TextEditingController();
    editarController.text = tarefa.nome;
    bool? concluido;

    showDialog(
      context: context,
      builder: (context) {
        String? erroTextoTarefa;

        return StatefulBuilder(
          builder: (context, setStateModal) {
            bool validarESalvar() {
              if (editarController.text.isEmpty || concluido == null) {
                setStateModal(() {
                  erroTextoTarefa = "Preencha o texto e selecione uma opção!";
                });
                return false;
              }

              setState(() {
                tarefa.nome = editarController.text;
                tarefa.concluida = concluido!;
              });

              return true;
            }

            return AlertDialog(
              title: Text("Editar Tarefa"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: editarController,
                    decoration: InputDecoration(
                      labelText: "Digite a nova tarefa",
                      border: OutlineInputBorder(),
                      errorText: erroTextoTarefa,
                      errorMaxLines: 2,
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField<bool>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      errorText: erroTextoTarefa,
                      errorMaxLines: 2,
                    ),
                    initialValue: concluido,
                    hint: Text("Selecione um valor"),
                    items: valores_bool.map((e) {
                      return DropdownMenuItem<bool>(
                        child: e ? Text("Concluída") : Text("Não concluída"),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (novoValor) {
                      setState(() {
                        concluido = novoValor;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancelar"),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 17, 119, 100),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Salvar"),
                  onPressed: () {
                    if (validarESalvar()) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "ToDo",
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
                  itemCount: tarefas.length,

                  itemBuilder: (context, index) {
                    final tarefa = tarefas[index];
                    return ListTile(
                      leading: Icon(Icons.task),
                      title: Text(
                        tarefa.nome,
                        style: TextStyle(
                          decoration: tarefa.concluida
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: tarefa.concluida ? Colors.grey : Colors.black,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                tarefa.concluida = !tarefa.concluida;
                              });
                            },
                            icon: tarefa.concluida
                                ? Icon(Icons.check_box)
                                : Icon(Icons.check_box_outline_blank),
                            color: tarefa.concluida
                                ? Colors.green
                                : Colors.black,
                          ),
                          IconButton(
                            onPressed: () => editarTarefa(tarefa: tarefa),

                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                tarefas.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            TextField(
              controller: tarefaDigitada,
              decoration: InputDecoration(
                icon: Icon(Icons.add_task),
                helperText: "Não deixe o campo vazio!",
                helperMaxLines: 2,
                errorText: erro,
                labelText: "Digite uma tarefa para ser adicionada à lista!",
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
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
