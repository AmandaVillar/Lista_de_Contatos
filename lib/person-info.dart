class Person {
  String name = '';
  String mobile = '';
  String image = '';
  int id;
  Person(this.name, this.mobile, this.image, this.id);

  static List<Person> getPersonList() {
    List<Person> personList = [];
    return personList;
  }
}
