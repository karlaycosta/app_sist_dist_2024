import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool tarefa = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tarefa)
              const SizedBox(
                height: 200,
                width: 200,
                child: CircularProgressIndicator(strokeWidth: 8),
              ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                setState(() {
                  tarefa = !tarefa;
                  Future.delayed(const Duration(seconds: 3)).then(
                    (value) {
                      Isolate.run(bubbleSort).then(
                        (value) {
                          setState(() {
                            tarefa = !tarefa;
                          });
                        },
                      );
                      Isolate.run(bubbleSort);
                      Isolate.run(bubbleSort);
                      Isolate.run(bubbleSort);
                      // bubbleSort().then(
                      //   (value) {
                      //     setState(() {
                      //       tarefa = !tarefa;
                      //     });
                      //   },
                      // );
                    },
                  );
                });
              },
              child: const Text('Tarefa'),
            )
          ],
        ),
      ),
    );
  }
}

const max = 100000;

Future<void> bubbleSort() async {
  print('Iniciou...');
  final timer = Stopwatch()..start();
  final rand = Random();
  final lista = List.generate(max, (index) => rand.nextInt(max));
  for (var i = 0; i < lista.length; i++) {
    for (var j = 0; j < lista.length - 1; j++) {
      if (lista[j] > lista[j + 1]) {
        final tmp = lista[j];
        lista[j] = lista[j + 1];
        lista[j + 1] = tmp;
      }
    }
  }
  timer.stop();
  print('${timer.elapsed}');
}
