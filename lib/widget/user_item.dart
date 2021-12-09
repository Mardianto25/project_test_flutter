import 'package:flutter/material.dart';
import 'package:project_belajar/models/user.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({Key? key, required this.user}) : super(key: key);

  final UserData user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar!)),
        title: Text(user.name!),
        isThreeLine: true,
        subtitle: Text(user.id.toString()),
        dense: true,
      ),
    );
  }
}
