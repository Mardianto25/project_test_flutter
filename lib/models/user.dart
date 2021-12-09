class UserData {
  final int id;
  final String? name;
  final String? avatar;

  UserData({required this.id, this.name, this.avatar});

  //mapping json data
  factory UserData.fromJSON(Map<String, dynamic> jsonMap) {
    final data = UserData(
        id: jsonMap["id"],
        name: jsonMap["login"],
        avatar: jsonMap["avatar_url"]);
    return data;
  }
}
