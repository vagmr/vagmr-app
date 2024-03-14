const name = "vagmr";

String getFullName(String firstName, String lastName) {
  return "$firstName $lastName";
}

var add = (int a, int b) => a + b;
void test() {
  const int a = 10;
  if (a > add(10, 20)) print("true");
  print("false");
}

void main() {
  print(getFullName("vagmr", "kumar"));
  test();
}
