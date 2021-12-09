import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:project_belajar/models/user.dart';
import 'package:project_belajar/resource/api_repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'user_event.dart';
part 'user_state.dart';

const _userLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiRepository _apiRepository;
  UserBloc(this._apiRepository) : super(const UserState()) {
    on<UserFetched>(
      _onUserFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onUserFetched(
    UserFetched event,
    Emitter<UserState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == UserStatus.initial || event.search == "search") {
        final users = await _apiRepository.fetchUserList(
            event.name, event.page, event.perpage);
        return emit(state.copyWith(
          status: UserStatus.success,
          users: users,
          hasReachedMax: false,
        ));
      }
      final users = await _apiRepository.fetchUserList(
          event.name, event.page, event.perpage);
      users.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: UserStatus.success,
                users: List.of(state.users)..addAll(users),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }
}
