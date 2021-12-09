part of 'user_bloc.dart';

enum UserStatus { initial, success, failure }

class UserState extends Equatable {
  const UserState({
    this.status = UserStatus.initial,
    this.users = const <UserData>[],
    this.hasReachedMax = false,
  });

  final UserStatus status;
  final List<UserData> users;
  final bool hasReachedMax;

  UserState copyWith({
    UserStatus? status,
    List<UserData>? users,
    bool? hasReachedMax,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''UserState { status: $status, hasReachedMax: $hasReachedMax, Users: ${users.length} }''';
  }

  @override
  List<Object> get props => [status, users, hasReachedMax];
}
