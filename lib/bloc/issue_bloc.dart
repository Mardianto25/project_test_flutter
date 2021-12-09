import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_belajar/models/issue.dart';
import 'package:project_belajar/resource/api_repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'issue_event.dart';
part 'issue_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  final ApiRepository _apiRepository;
  IssueBloc(this._apiRepository) : super(const IssueState()) {
    on<IssueFetched>(
      _onIssueFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onIssueFetched(
    IssueFetched event,
    Emitter<IssueState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == IssueStatus.initial || event.search == "search") {
        final issues = await _apiRepository.fetchIssueList(
            event.name, event.page, event.perpage);
        return emit(state.copyWith(
          status: IssueStatus.success,
          issues: issues,
          hasReachedMax: false,
        ));
      }
      final issues = await _apiRepository.fetchIssueList(
          event.name, event.page, event.perpage);
      issues.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: IssueStatus.success,
                issues: List.of(state.issues)..addAll(issues),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: IssueStatus.failure));
    }
  }
}
