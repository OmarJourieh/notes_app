import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
    Note({
        this.id,
        this.title,
        this.body,
        this.createdAt,
        this.image,
        this.category,
        this.isDeleted,
        this.isArchived,
        this.isBookmarked,
    });

    int id;
    String title;
    String body;
    String createdAt;
    String image;
    String category;
    int isDeleted;
    int isArchived;
    int isBookmarked;

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: json["createdAt"],
        image: json["image"],
        category: json["category"],
        isDeleted: json["isDeleted"],
        isArchived: json["isArchived"],
        isBookmarked: json["isBookmarked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "createdAt": createdAt,
        "image": image,
        "category": category,
        "isDeleted": isDeleted,
        "isArchived": isArchived,
        "isBookmarked": isBookmarked,
    };
}