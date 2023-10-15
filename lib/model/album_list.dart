class AlbumModel {
  dynamic? userId;
  dynamic? id;
  String? title;

  AlbumModel({this.userId, this.id, this.title});

  AlbumModel.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
