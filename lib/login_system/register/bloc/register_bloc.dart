import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:device_tracker/helper/validators.dart';
import 'package:device_tracker/login_system/register/bloc/register_event.dart';
import 'package:device_tracker/login_system/register/bloc/register_state.dart';
import 'package:device_tracker/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  static const debounceUsernameDuration = Duration(milliseconds: 300);

  RegisterBloc({required UserRepository userRepository}) : assert(userRepository != null), _userRepository = userRepository, super(RegisterState.empty()){
    // on<EmailChanged>((event, emit) async{
    //   emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
    // },transformer: debounceRestartable(RegisterBloc.debounceUsernameDuration));
    // on<PasswordChanged>((event, emit) async{
    //   emit(state.update(isPasswordValid: Validators.isValidPassword(event.password)));
    // },transformer: debounceRestartable(RegisterBloc.debounceUsernameDuration));
    // on<Submitted>((event, emit) async{
    //   emit(RegisterState.loading());
    //   try {
    //     await _userRepository.signUp(
    //       email: event.email,
    //       password: event.password,
    //     );
    //      RegisterState.success();
    //   } catch (_) {
    //      RegisterState.failure();
    //   }
    // },transformer: sequential());
  }

  @override
  RegisterState get initialState => RegisterState.empty();

  // @override
  // Stream<RegisterState> transform(
  //     Stream<RegisterEvent> events,
  //     Stream<RegisterState> Function(RegisterEvent event) next,
  //     ) {
  //   final observableStream = events as Observable<RegisterEvent>;
  //   final nonDebounceStream = observableStream.where((event) {
  //     return (event is! EmailChanged && event is! PasswordChanged);
  //   });
  //   final debounceStream = observableStream.where((event) {
  //     return (event is EmailChanged || event is PasswordChanged);
  //   }).debounce(Duration(milliseconds: 300));
  //   return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  // }

  EventTransformer<LoginEvent> debounceRestartable<LoginEvent>(Duration duration) {
    return (events, mapper) => restartable<LoginEvent>().call(events.debounceTime(duration), mapper);
  }

  EventTransformer<Event> restartable<Event>() {
    return (events, mapper) => events.switchMap(mapper);
  }

  EventTransformer<Event> sequential<Event>() {
    return (events, mapper) => events.asyncExpand(mapper);
  }


//@override
// Stream<Transition<RegisterEvent, RegisterState>> transformEvents(Stream<RegisterEvent> events, TransitionFunction<RegisterEvent, RegisterState> transitionFn) {
//   final nonDebounceStream = events.where((event) {
//     return (event is! EmailChanged && event is! PasswordChanged);
//   });
//   final debounceStream = events.where((event) {
//     return (event is EmailChanged || event is PasswordChanged);
//   }).debounceTime(Duration(milliseconds: 300));
//   return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]),
//     transitionFn,
//   );
// }
}