import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_belajar/models/repo.dart';
import 'package:project_belajar/resource/api_repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'repo_event.dart';
part 'repo_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  final ApiRepository _apiRepository;
  RepoBloc(this._apiRepository) : super(const RepoState()) {
    on<RepoFetched>(
      _onRepoFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onRepoFetched(
    RepoFetched event,
    Emitter<RepoState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == RepoStatus.initial || event.search == "search") {
        final repos = await _apiRepository.fetchRepoList(
            event.name, event.page, event.perpage);
        return emit(state.copyWith(
          status: RepoStatus.success,
          repos: repos,
          hasReachedMax: false,
        ));
      }
      final repos = await _apiRepository.fetchRepoList(
          event.name, event.page, event.perpage);
      repos.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: RepoStatus.success,
                repos: List.of(state.repos)..addAll(repos),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: RepoStatus.failure));
    }
  }
}
