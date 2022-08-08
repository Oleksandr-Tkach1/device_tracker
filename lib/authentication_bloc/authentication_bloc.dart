import 'package:bloc/bloc.dart';
import 'package:device_tracker/repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository}) : assert(userRepository != null), _userRepository = userRepository, super(Uninitialized()){
    on<AppStarted>((event, emit) async{
      emit(Uninitialized());
      try {
        final isSignedIn = await _userRepository.isSignedIn();
        if (isSignedIn) {
          final email = await _userRepository.getUser();
          emit(Authenticated(email!));
        } else {
          emit(Unauthenticated());
        }
      } catch (_) {
        emit(Unauthenticated());
      }
    });
    on<LoggedIn>((event, emit) async{
      emit(Authenticated(await _userRepository.getUser()));
    });
    on<LoggedOut>((event, emit) async{
      emit(Unauthenticated());
      _userRepository.signOut();
    });
  }

  @override
  AuthenticationState get initialState => Uninitialized();

// @override
// Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
//   if (event is AppStarted) {
//     yield* _mapAppStartedToState();
//   } else if (event is LoggedIn) {
//     yield* _mapLoggedInToState();
//   } else if (event is LoggedOut) {
//     yield* _mapLoggedOutToState();
//   }
// }

// Stream<AuthenticationState> _mapAppStartedToState() async* {
//   try {
//     final isSignedIn = await _userRepository.isSignedIn();
//     if (isSignedIn) {
//       final email = await _userRepository.getUser();
//       yield Authenticated(email!);
//     } else {
//       yield Unauthenticated();
//     }
//   } catch (_) {
//     yield Unauthenticated();
//   }
// }
//
// Stream<AuthenticationState> _mapLoggedInToState() async* {
//   yield Authenticated(await _userRepository.getUser());
// }
//
// Stream<AuthenticationState> _mapLoggedOutToState() async* {
//   yield Unauthenticated();
//   _userRepository.signOut();
// }
}