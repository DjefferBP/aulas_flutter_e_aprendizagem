import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_teste_1/app_scaffold.dart';
import 'package:app_teste_1/class/itemCompra.dart';

class ListaDeComprasPage extends StatefulWidget {
  @override
  _ListaDeComprasToDo createState() => _ListaDeComprasToDo();
}

class _ListaDeComprasToDo extends State<ListaDeComprasPage> {
  Timer? _debounce;

  List<ItemCompra> compras = [
    ItemCompra(nomeItem: "Arroz", quantidade: 5),
    ItemCompra(nomeItem: "Feijão", quantidade: 2),
    ItemCompra(nomeItem: "Macarrão", quantidade: 3),
    ItemCompra(nomeItem: "Leite", quantidade: 6),
    ItemCompra(nomeItem: "Pão", quantidade: 10),
    ItemCompra(nomeItem: "Carne", quantidade: 2),
    ItemCompra(nomeItem: "Frango", quantidade: 4),
    ItemCompra(nomeItem: "Detergente", quantidade: 2),
    ItemCompra(nomeItem: "Sabão em pó", quantidade: 1),
    ItemCompra(nomeItem: "Amaciante", quantidade: 1),
    ItemCompra(nomeItem: "Papel higiênico", quantidade: 12),
    ItemCompra(nomeItem: "Shampoo", quantidade: 1),
    ItemCompra(nomeItem: "Condicionador", quantidade: 1),
    ItemCompra(nomeItem: "Desinfetante", quantidade: 2),
  ];
  TextEditingController pesquisaController = TextEditingController();

  List<ItemCompra> get comprasFiltradas {
    return compras.where((item) {
      final matchFiltro =
          filtroConcluido == null || item.concluido == filtroConcluido;
      final matchBusca = item.nomeItem.toLowerCase().contains(
        pesquisaController.text.toLowerCase(),
      );

      return matchFiltro && matchBusca;
    }).toList();
  }

  int get totalComprasConcluidas {
    return compras.where((item) => item.concluido).toList().length;
  }

  bool? filtroConcluido;

  @override
  void dispose() {
    pesquisaController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void adicionarCompra() {
    TextEditingController compraNome = TextEditingController();
    TextEditingController qtdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        String? erroNome;
        String? erroNumero;

        return StatefulBuilder(
          builder: (context, setStateModal) {
            bool validarESalvar() {
              if (compraNome.text.isEmpty) {
                setStateModal(() {
                  erroNome = "Escreva o nome do item a ser comprado!";
                });
                return false;
              }
              if (qtdController.text.isEmpty ||
                  int.tryParse(qtdController.text)! <= 0) {
                setStateModal(() {
                  erroNumero =
                      "O texto não deve ser branco e o valor mínimo é 1!";
                });
                return false;
              }
              String nomeItem = compraNome.text;
              ItemCompra it = ItemCompra(
                nomeItem: nomeItem,
                quantidade: int.tryParse(qtdController.text)!,
              );
              setState(() {
                compras.add(it);
              });

              return true;
            }

            return AlertDialog(
              title: Text("ADICIONAR ITEM PARA COMPRAR"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    style: TextStyle(color: Colors.black),
                    controller: compraNome,
                    decoration: InputDecoration(
                      labelText: "Nome do item",
                      border: OutlineInputBorder(),
                      errorText: erroNome,
                      labelStyle: TextStyle(color: Colors.black),
                      errorMaxLines: 2,
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 132, 131, 131),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: qtdController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Quantidade",
                            border: OutlineInputBorder(),
                            errorText: erroNumero,
                            errorMaxLines: 2,
                          ),
                        ),
                      ),

                      SizedBox(width: 8),

                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              int atual = int.tryParse(qtdController.text) ?? 0;
                              qtdController.text = (atual + 1).toString();
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Icon(Icons.add, size: 18),
                            ),
                          ),

                          SizedBox(height: 4),

                          InkWell(
                            onTap: () {
                              int atual = int.tryParse(qtdController.text) ?? 0;
                              if (atual > 0) {
                                qtdController.text = (atual - 1).toString();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Icon(Icons.remove, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancelar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    if (validarESalvar()) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Adicionar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 23, 78, 122),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void removerItemCompraConcluido() {
    setState(() {
      compras.removeWhere((item) => item.concluido);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Lista de compras",
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchBar(
                    controller: pesquisaController,

                    hintText: "Pesquisar item...",

                    leading: Icon(Icons.search),
                    trailing: [
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          pesquisaController.clear();
                          setState(() {});
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],

                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(Duration(milliseconds: 300), () {
                        setState(() {});
                      });
                    },
                    backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
                    elevation: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.focused)) {
                        return 5;
                      }
                      return 0;
                    }),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey),
                      ),
                    ),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            // LINHA 2
            Row(
              children: [
                Text(
                  "Total concluídas: $totalComprasConcluidas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownMenu<bool?>(
                    width: 200,
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    initialSelection: filtroConcluido,

                    dropdownMenuEntries: [
                      DropdownMenuEntry<bool?>(label: "Todas", value: null),
                      DropdownMenuEntry<bool?>(label: "Compradas", value: true),
                      DropdownMenuEntry<bool?>(
                        label: "Não compradas",
                        value: false,
                      ),
                    ],
                    onSelected: (bool? valor) {
                      setState(() {
                        filtroConcluido = valor;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: removerItemCompraConcluido,
                    icon: Icon(Icons.delete_sweep),
                    label: Text("Limpar comprados"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        for (var item in compras) {
                          item.concluido = true;
                        }
                      });
                    },
                    icon: Icon(Icons.check_circle),
                    label: Text("Marcar todos"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 83, 59, 189),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: comprasFiltradas.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Não há itens",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: comprasFiltradas.length,
                        itemBuilder: (context, index) {
                          final item = comprasFiltradas[index];

                          return Dismissible(
                            key: Key(item.nomeItem + index.toString()),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (_) {
                              setState(() {
                                compras.remove(item);
                              });
                            },

                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  item.concluido = !item.concluido;
                                });
                              },
                              child: Card(
                                elevation: 3,
                                margin: EdgeInsets.symmetric(vertical: 6),
                                color: item.concluido
                                    ? Colors.green[50]
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: item.concluido
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),

                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: item.concluido,
                                        onChanged: (value) {
                                          setState(() {
                                            item.concluido = value!;
                                          });
                                        },
                                      ),

                                      SizedBox(width: 8),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.nomeItem,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: item.concluido
                                                    ? Colors.grey
                                                    : Colors.black,
                                                decoration: item.concluido
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Text("Quantidade"),
                                      SizedBox(width: 5),
                                      SizedBox(
                                        width: 50,
                                        height: 40,
                                        child: TextFormField(
                                          initialValue: item.quantidade
                                              .toString(),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  vertical: 8,
                                                ),
                                          ),
                                          onChanged: (value) {
                                            int? novaQtd = int.tryParse(value);
                                            if (novaQtd != null &&
                                                novaQtd > 0) {
                                              setState(() {
                                                item.quantidade = novaQtd;
                                              });
                                            }
                                          },
                                        ),
                                      ),

                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            compras.remove(item);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarCompra,
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 23, 78, 122),
        foregroundColor: Colors.white,
      ),
    );
  }
}
