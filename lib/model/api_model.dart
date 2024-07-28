class ApiModel {
  final int id;
  final String title;
  final String body;

  ApiModel({required this.id, required this.title, required this.body});

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  toJson(ApiModel apiModel) {
    return {
      'id': apiModel.id,
      'title': apiModel.title,
      'body': apiModel.body,
    };
  }
}
