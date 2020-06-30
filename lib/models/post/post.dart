class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(
    this.userId,
    this.id,
    this.title,
    this.body,
  );

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        json["userId"],
        json["id"],
        json["title"],
        json["body"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
