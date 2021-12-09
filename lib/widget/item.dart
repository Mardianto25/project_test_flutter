import 'package:flutter/material.dart';
import 'package:project_belajar/models/issue.dart';

class IssueListItem extends StatelessWidget {
  const IssueListItem({Key? key, required this.issue}) : super(key: key);

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(issue.url!)),
        title: Text(issue.title!),
        isThreeLine: true,
        trailing: Text(issue.state!),
        subtitle: Text(issue.updatedAt!),
        dense: true,
      ),
    );
  }
}
