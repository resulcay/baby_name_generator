class Girl {
  late final int girlId;
  late final String name;
  late final String description;

  Girl({required this.name, required this.description});

  Girl.fromJson(Map<String, dynamic> json) {
    girlId = json['girlId'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // Because of SQLite PrimaryKey Constrains.
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class Boy {
  late final int boyId;
  late final String name;
  late final String description;

  Boy({required this.name, required this.description});

  Boy.fromJson(Map<String, dynamic> json) {
    boyId = json['boyId'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // Because of SQLite PrimaryKey Constrains.
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
