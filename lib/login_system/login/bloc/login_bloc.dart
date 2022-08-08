import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:device_tracker/helper/validators.dart';
import 'package:device_tracker/login_system/login/bloc/login_event.dart';
import 'package:device_tracker/login_system/login/bloc/login_state.dart';
import 'package:device_tracker/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

/// BLoC responsible for the business logic behind the login process. In particular this BLoC will
/// map the incoming [LoginEvent] to the correct [LoginState].
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Authentication repository that provides to the user the methods to sign-in
  /// with credentials and to sign-in with a Google account.
  final UserRepository userRepository;
  static const debounceUsernameDuration = Duration(milliseconds: 300);

  LoginBloc({required this.userRepository}) : assert(userRepository != null), super(LoginState.empty()){
    on<EmailChanged>((event, emit) async{
      emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
    },transformer: debounceRestartable(LoginBloc.debounceUsernameDuration));
    on<PasswordChanged>((event, emit) async{
      emit(state.update(isPasswordValid: Validators.isValidPassword(event.password)));
    },transformer: debounceRestartable(LoginBloc.debounceUsernameDuration));
    on<LoginWithCredentialsPressed>((event, emit) async{
      emit(LoginState.loading());
      try {
        await userRepository.signInWithCredentials(email: event.email, password: event.password);
        emit(LoginState.success());
      } catch (_) {
        emit(LoginState.failure());
      }
    }, transformer: sequential());
  }

  @override
  LoginState get initialState => LoginState.empty();

  EventTransformer<LoginEvent> debounceRestartable<LoginEvent>(Duration duration) {
    return (events, mapper) => restartable<LoginEvent>().call(events.debounceTime(duration), mapper);
  }

  EventTransformer<Event> restartable<Event>() {
    return (events, mapper) => events.switchMap(mapper);
  }

  EventTransformer<Event> sequential<Event>() {
    return (events, mapper) => events.asyncExpand(mapper);
  }
}