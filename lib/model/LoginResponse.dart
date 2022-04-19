class LoginResponseObject {
  String id = "";
  String email = "";
  String role = "";
  String token = "";
  String firstName = "";
  String lastName = "";
  String expiration = "";

  LoginResponseObject(this.id, this.email, this.role, this.token,
      this.firstName, this.lastName, this.expiration);

  LoginResponseObject.empty() {
    id = "";
    email = "";
    role = "";
    token = "";
    firstName = "";
    lastName = "";
    expiration = "";
  }

  //deserialization
  factory LoginResponseObject.fromJson(Map<String, dynamic> json) {
    return LoginResponseObject(
      json["id"] as String,
      json["email"] as String,
      json["role"] as String,
      json["token"] as String,
      json["firstName"] as String,
      json["lastName"] as String,
      json["expiration"] as String,
    );
  }

  //serialization
  Map<String, dynamic> toJson() {
    var map = {
      "id": id,
      "email": email,
      "role": role,
      "token": token,
      "firstName": firstName,
      "lastName": lastName,
      "expiration": expiration,
    };
    return map;
  }

  @override
  String toString() {
    return "LoginResponseObject = [ id: $id, email: $email, role: $role, token: $token "
        "firstName: $firstName, lastName : $lastName , expiration: $expiration]";
  }
}
