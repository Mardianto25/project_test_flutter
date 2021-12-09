part of 'issue_bloc.dart';

enum IssueStatus { initial, success, failure }

class IssueState extends Equatable {
  const IssueState({
    this.status = IssueStatus.initial,
    this.issues = const <Issue>[],
    this.hasReachedMax = false,
  });

  final IssueStatus status;
  final List<Issue> issues;
  final bool hasReachedMax;

  IssueState copyWith({
    IssueStatus? status,
    List<Issue>? issues,
    bool? hasReachedMax,
  }) {
    return IssueState(
      status: status ?? this.status,
      issues: issues ?? this.issues,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''IssueState { status: $status, hasReachedMax: $hasReachedMax, Issues: ${issues.length} }''';
  }

  @override
  List<Object> get props => [status, issues, hasReachedMax];
}
