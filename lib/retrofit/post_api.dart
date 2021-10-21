import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'post_api.g.dart';

@RestApi(baseUrl: "http://dairy.knickglobal.com/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
  @POST("/api/register")
  Future<Post> getTasks(
      String name,
      String lname,
      String email,
      String phone_number,
      String reference_code,
      String password);
}

@JsonSerializable()
class Post{
  String name;
  String lname;
  String email;
  String phone_number;
  String reference_code;
  String password;
  Post({this.name, this.lname, this.email, this.phone_number, this.reference_code, this.password});
  factory Post.fromJson(Map<String, dynamic> json) =>  _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}