// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    name: json['name'] as String,
    lname: json['lname'] as String,
    email: json['email'] as String,
    phone_number: json['phone_number'] as String,
    reference_code: json['reference_code'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'name': instance.name,
      'lname': instance.lname,
      'email': instance.email,
      'phone_number': instance.phone_number,
      'reference_code': instance.reference_code,
      'password': instance.password,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://dairy.knickglobal.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Post> getTasks(name,lname,email, phone_number,reference_code,password) async {
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(lname, 'lname');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(phone_number, 'phone_number');
    ArgumentError.checkNotNull(reference_code, 'reference_code');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{"HttpHeaders.acceptHeader": "accept: application/json"},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Post.fromJson(_result.data);
    return value;
  }
}
