class Location {
  final int id;
  final String type;
  final String title;

//  Location(this.id, this.type, this.title);

  Location.fromJson(Map json)
      : id = json['entity_id'],
        type = json['entity_type'],
        title = json['title'];
}
