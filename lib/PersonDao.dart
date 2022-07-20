// import 'package:teste/person-info.dart';

// class PersonDao {
//   static PersonDao _personDao;
//   static Database _database; //

//   static const String _person = 'person';
//   static const String _id = 'id';
//   static const String _name = 'name';
//   static const String _mobile = 'mobile';
//   static const String _image = 'image';

//   static const String tableSql = 'CREATE TABLE contacts('
//       'id INTEGER PRIMARY KEY, '
//       'name TEXT, '
//       'accountNumber INTEGER)';

//   Future<int> save(Person contact) async {
//     final Database db = await getDatabase();
//     Map<String, dynamic> contactMap = _toMap(contact);
//     return db.insert(_person, contactMap);
//   }

//   Future<List<Person>> findAll() async {
//     final Database db = await getDatabase();
//     final List<Map<String, dynamic>> result = await db.query(_person);
//     List<Person> contacts = _toList(result);
//     return contacts;
//   }

//   List<Person> _toList(List<Map<String, dynamic>> result) {
//     final List<Person> contacts = [];
//     for (Map<String, dynamic> row in result) {
//       final Person contact = Person(
//         row[_id],
//         row[_name],
//         row[_mobile],
//         row[_image],
//       );
//       contacts.add(contact);
//     }
//     return contacts;
//   }

//   Map<String, dynamic> _toMap(Person contact) {
//     final Map<String, dynamic> contactMap = {};
//     contactMap[_name] = contact.name;
//     contactMap[_mobile] = contact.mobile;
//     return contactMap;
//   }
// }
