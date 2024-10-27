
// reference: https://github.com/dart-lang/sdk/issues/34567
// https://stackoverflow.com/questions/54035675/mixins-in-dart-2-1-on-keyword

mixin A {

  void eat() {
    print('A eat');
  }
}
// B extends A
mixin B on A {
  @override
  void eat() {
    print('B eat');
  }
  void walk(){
    print('B Walk');
  }
}
