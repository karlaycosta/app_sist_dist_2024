import 'dart:convert';
import 'dart:isolate';

class Worker {
  /// Criação do Isolado
  Future<void> spawn() async {
    // Recebe comandos do novo isolado
    final receivePort = ReceivePort();
    receivePort.listen((message) {

    });
    await Isolate.spawn(_startRemoteIsolate, receivePort.sendPort);
  }

  static void _startRemoteIsolate(SendPort port) {
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);

    receivePort.listen((dynamic message) async {
      if (message is String) {
        final transformed = jsonDecode(message);
        port.send(transformed);
      }
    });
  }

  // void _handleResponsesFromIsolate(dynamic message) {
  //   // TODO: Handle messages sent back from the worker isolate.
  // }

  // Future<void> parseJson(String message) async {
  //   // TODO: Define a public method that can
  //   // be used to send messages to the worker isolate.
  // }

}
