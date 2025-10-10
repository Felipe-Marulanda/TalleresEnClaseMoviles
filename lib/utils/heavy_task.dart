import 'dart:isolate';

// Función para usar con Isolate.spawn
void heavyComputation(SendPort sendPort) {
  int sum = 0;
  for (int i = 0; i < 100000; i++) {
    sum += i % 10;
  }
  sendPort.send(sum);
}

// Función para usar con compute
int heavyTask(int iterations) {
  int sum = 0;
  for (int i = 0; i < iterations; i++) {
    for (int j = 0; j < 100000; j++) {
      sum += (i * j) % 7;
    }
  }
  return sum;
}
