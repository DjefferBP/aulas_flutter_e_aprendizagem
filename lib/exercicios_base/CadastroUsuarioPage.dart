import 'package:flutter/material.dart';
import 'package:app_teste_1/app_scaffold.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool mostrarSenha = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Cadastro de usuários",
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite seu nome!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite seu e-mail!";
                  }
                  if (!value.contains("@")) {
                    return "E-mail inválido!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: senhaController,
                decoration: InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      mostrarSenha = !mostrarSenha;
                    },
                    icon: Icon(
                      mostrarSenha ? Icons.visibility : Icons.visibility_off,
                      color: mostrarSenha ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                obscureText: !mostrarSenha,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite sua senha!";
                  }
                  if (value.length < 6) {
                    return "Mínimo 6 caracteres!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),

                  child: Text("Enviar"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Formulário válido!"),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else
                      return;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
