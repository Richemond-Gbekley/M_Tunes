class CreateUserReq {
  final String email;
  final String password;
  final String name;
  final String gender;
  final DateTime dob;

  CreateUserReq({
    required this.email,
    required this.password,
    required this.name,
    required this.gender,
    required this.dob,
  });
}
