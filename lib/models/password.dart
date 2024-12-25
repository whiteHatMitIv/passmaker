class Password {
  String id;
  String passwordString;

  Password({
    required this.id,
    required this.passwordString
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "passwordString": passwordString
    };
  }

  factory Password.fromMap(Map<String, dynamic> map) {
    return Password(
      id: map["id"], 
      passwordString: map["passwordString"]
    );
  }
}