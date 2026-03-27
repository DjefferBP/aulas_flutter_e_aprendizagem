import 'package:flutter/material.dart';
import 'package:app_teste_1/exercicios_base/ToDoSimplespage.dart';


void main() {
  runApp(TodosimplesPage());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
int _contador = 0;

  @override
  Widget build(BuildContext context) {
    

    void incrementar() {
      setState(() {
        _contador += 1;
      }); 
    }

    void decrementar() {
      setState(() {
        _contador -= 1;
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Center(
              child: Text("$_contador", style: TextStyle(
                color: _contador > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 34
              ),),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
                  onPressed:incrementar,
                  child: Icon(Icons.add),
                  backgroundColor: const Color.fromARGB(255, 34, 133, 37),
                  foregroundColor: Colors.white,
                ),
                SizedBox(width: 10,),
                FloatingActionButton(
                  onPressed:decrementar,
                  child: Icon(Icons.remove),
                  backgroundColor: const Color.fromARGB(255, 137, 56, 51),
                  foregroundColor: Colors.white,
                )
        ],
      )
      
    );
  }
}
