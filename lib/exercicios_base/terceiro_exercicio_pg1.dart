import 'package:flutter/material.dart';
import 'terceiro_exercicio_pg2.dart';

class TerceiroExercicioPg1 extends StatelessWidget {
  const TerceiroExercicioPg1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TerceiroExercicio1(),
    );
  }
}

class TerceiroExercicio1 extends StatefulWidget {
  const TerceiroExercicio1({Key? key}) : super(key: key);

  @override
  State<TerceiroExercicio1> createState() => _TerceiroExercicio1State();
}

class _TerceiroExercicio1State extends State<TerceiroExercicio1> {
  @override
  Widget build(BuildContext context) {
    
    

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Terceiro Exercício',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => TerceiroExercicioPg2()));
                },
                child: const Text("NAVEGAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
