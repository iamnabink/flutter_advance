main() {
  dynamic name; // If a variable is declared as dynamic you can change its type anytime.
  Object name2; // While if a variable is declared with var keyword and have an initial value its type can't be changed else if it's not initialized you can change its DataType anytime
  name = 'hari';
  name2 = 'hari';
  print(name);
  name2 = 1;
  print(name);
  print(name2);
}