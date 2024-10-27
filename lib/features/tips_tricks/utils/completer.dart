import 'dart:async'; // To use Completer

void main() {
  // Step 1: Create a Completer
  Completer<String> completer = Completer<String>();

  // Step 2: Get the Future from the Completer
  Future<String> future = completer.future;

  // Step 3: Somewhere else in the code, wait for the Future to complete
  future.then((result) {
    print("Task completed: $result");
  });

  // Step 4: Complete the task manually (this can happen later)
  print("Simulating a delay...");
  Future.delayed(Duration(seconds: 2), () {
    completer.complete("File downloaded successfully");
  });

  // You can also complete with an error:
  // completer.completeError("Something went wrong");
}

// output:

// Simulating a delay...
// Task completed: File downloaded successfully