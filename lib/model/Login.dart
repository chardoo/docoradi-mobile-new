class Login {
  String email = "";
  String password = "";

  Login(this.email, this.password);

  Login.empty() {
    email = "";
    password = "";
  }

  //deserialization
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      json["email"] as String,
      json["password"] as String,
    );
  }

  //serialization
  Map<String, dynamic> toJson() {
    var map = {
      "email": email,
      "password": password,
    };
    return map;
  }
}
