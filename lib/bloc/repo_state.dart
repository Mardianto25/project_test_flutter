part of 'repo_bloc.dart';

enum RepoStatus { initial, success, failure }

class RepoState extends Equatable {
  const RepoState({
    this.status = RepoStatus.initial,
    this.repos = const <RepoData>[],
    this.hasReachedMax = false,
  });

  final RepoStatus status;
  final List<RepoData> repos;
  final bool hasReachedMax;

  RepoState copyWith({
    RepoStatus? status,
    List<RepoData>? repos,
    bool? hasReachedMax,
  }) {
    return RepoState(
      status: status ?? this.status,
      repos: repos ?? this.repos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''RepoState { status: $status, hasReachedMax: $hasReachedMax, Repos: ${repos.length} }''';
  }

  @override
  List<Object> get props => [status, repos, hasReachedMax];
}
