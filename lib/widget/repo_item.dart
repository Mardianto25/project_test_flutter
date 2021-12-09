import 'package:flutter/material.dart';
import 'package:project_belajar/models/repo.dart';

class RepoListItem extends StatelessWidget {
  const RepoListItem({Key? key, required this.repo}) : super(key: key);

  final RepoData repo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(repo.url)),
        title: Text(repo.name!),
        isThreeLine: true,
        trailing: Column(
          children: [
            Text(repo.watchCount.toString()),
            Text(repo.forksCount.toString()),
            Text(repo.starCount.toString()),
          ],
        ),
        subtitle: Text(repo.id.toString()),
        dense: true,
      ),
    );
  }
}
