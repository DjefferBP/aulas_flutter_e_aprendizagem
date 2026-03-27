import 'package:flutter/material.dart';

class TerceiroExercicioPg2 extends StatefulWidget {
  
  @override
  State<TerceiroExercicioPg2> createState() => _TerceiroExercicio2State();
}


class _TerceiroExercicio2State extends State<TerceiroExercicioPg2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
            'Você chegou!',
            style: TextStyle(fontSize: 30),
            selectionColor: Colors.blueAccent,
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
                  Navigator.pop(context); 
                },
                child: const Text("VOLTAR"),
              ),
            )
          ]
        ),
      ),
    );
  }
}