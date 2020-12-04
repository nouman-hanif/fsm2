import 'builders/co_region_builder.dart';

import 'builders/fork_builder.dart';
import 'builders/graph_builder.dart';
import 'builders/join_builder.dart';
import 'builders/state_builder.dart';
import 'definitions/state_definition.dart';

abstract class State {}

/// Class used to represent an implicit terminal [State].
///
/// A [State] is considered terminal if it has no explicit transitions ([on], [onFork], [onJoin])
/// events defined for it.
// class TerminalState extends State {}

/// Special class used to represent the final/terminal state of the FSM.
/// If you add an 'on' transition to [FinalState] then an transition arrow to a final state
/// icon  will be displayed when you export your statemachine to a diagram.
class FinalState extends State {}

/// Used by the [StateMachine.history] to represent a pseudo 'first' event that
/// that indicates how we got in the FSM initialState.
class InitialEvent extends Event {}

/// Class used to represent an implicit event to a terminal [State].
///
/// A [State] is considered terminal if it has no explicit transitions ([on], [onFork], [onJoin])
/// events defined from it (e.g. there is no way to leave the state).
///
/// If a [State] is a terminal state we emmit an implicit transition from the [State] to
/// the [TerminalState] via a [TerminalEvent].
// class TerminalEvent extends Event {}

abstract class Event {}

typedef GuardCondition<E extends Event> = bool Function(E event);

typedef BuildGraph = void Function(GraphBuilder);

typedef SideEffect = Future<void> Function();

typedef OnEnter = Future<void> Function(Type fromState, Event event);
typedef OnExit = Future<void> Function(Type toState, Event event);

/// Callback when a transition occurs.
/// We pass, fromState, Event that triggered the transition and the target state.
/// A single event may result in multiple calls to the listener when we have
/// active concurrent regions.
typedef TransitionListener = void Function(
    StateDefinition, Event, StateDefinition);

/// The builder for a state.
typedef BuildState<S extends State> = void Function(StateBuilder<S>);

/// Builder for [coregion]
typedef BuildCoRegion<S extends State> = void Function(CoRegionBuilder<S>);

/// Builder for onFork
typedef BuildFork<E extends Event> = void Function(ForkBuilder<E>);

/// Builder for onJoin
typedef BuildJoin<S extends State> = void Function(JoinBuilder<S>);
