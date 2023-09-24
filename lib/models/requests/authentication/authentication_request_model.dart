import 'dart:convert';

AuthenticationRequestModel authenticationRequestModelFromJson(String str) => AuthenticationRequestModel.fromJson(json.decode(str));

String authenticationRequestModelToJson(AuthenticationRequestModel data) => json.encode(data.toJson());

class AuthenticationRequestModel {
    String? username;
    String? password;

    AuthenticationRequestModel({
        this.username,
        this.password,
    });

    factory AuthenticationRequestModel.fromJson(Map<String, dynamic> json) => AuthenticationRequestModel(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}
