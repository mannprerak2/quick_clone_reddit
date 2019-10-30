// top level variables
int a = 10;
double b = 10.34;

// function with optional positional parameter
int example1(int a, [int b = 10]) {
  return a + b;
}

// function with optional named parameter
String example2(int a, {String str1 = "default", String str2}) {
  return str1 + str2;
}

// lambda or arrow function (just a shorthand, returns a+b)
int add(int a, int b) => a + b;

// async function
void delayPrint() async {
  print("Can u wait for a second?");
  await Future.delayed(Duration(seconds: 1));
  print("Thanks for waiting");
}

void main() {
  //calling functions
  example2(10, str1: "hello", str2: "world");

  // string interpolation
  var a = 10, b = "number";
  String s = "${a.toString()} is my fav $b";

  a?.toString(); // only calls toString if a is not null
  int x = a ?? 10; // sets x to 10 if a is null

  // Futures in Dart
}
