import 'dart:convert';

AuthenticationResponseModel authenticationResponseModelFromJson(Map<String, dynamic> str) => AuthenticationResponseModel.fromJson(str);

String authenticationResponseModelToJson(AuthenticationResponseModel data) => json.encode(data.toJson());

class AuthenticationResponseModel {
    String? token;

    AuthenticationResponseModel({
        this.token,
    });

    factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) => AuthenticationResponseModel(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
