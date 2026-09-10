class Student {
  final String id;
  final String name;
  final String password;
  final String birthday;
  final String email;
  final String program;
  final String yearAndSection;

  Student({
    required this.id,
    required this.name,
    required this.password,
    required this.birthday,
    required this.email,
    required this.program,
    required this.yearAndSection,
  });
}

// Mock Database
final List<Student> studentDatabase = [
  Student(
    id: 'A2024-1049',
    name: 'Carmela Bueno',
    password: '0817',
    birthday: 'August 17, 2005',
    email: 'c.bueno@sti.edu.ph',
    program: 'BS Computer Science',
    yearAndSection: 'BSCS 3A',
  ),
  Student(
    id: 'A2024-1037',
    name: 'Katelyn Claire Tabernilla',
    password: '0418',
    birthday: 'April 18, 2005',
    email: 'k.tabernilla@sti.edu.ph',
    program: 'BS Computer Science',
    yearAndSection: 'BSCS 3A',
  ),
  Student(
    id: 'A2024-1034',
    name: 'Maricel Laurio',
    password: '0614',
    birthday: 'June 14, 2005',
    email: 'm.laurio@sti.edu.ph',
    program: 'BS Computer Science',
    yearAndSection: 'BSCS 3A',
  ),
];