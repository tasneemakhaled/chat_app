class Messagemodel {
  final String message;
  final String id;
  Messagemodel(this.message, this.id);
  factory Messagemodel.fromJson(json) {
    return Messagemodel(json['message'], json['id']);
  }
}
