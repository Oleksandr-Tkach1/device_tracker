import 'package:bloc/bloc.dart';
import 'package:device_tracker/repository/user_repository.dart';
import '../helper/device_inf.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => Uninitialized();
  final UserRepository _userRepository;
  late final DeviceInfo deviceInfo2 = DeviceInfo();
  AuthenticationBloc({required UserRepository userRepository}) : assert(userRepository != null), _userRepository = userRepository, super(Uninitialized()){
    on<AppStarted>((event, emit) async{
      emit(Uninitialized());
      try {
        final isSignedIn = await _userRepository.isSignedIn();
        if (isSignedIn) {
          emit(Authenticated((await _userRepository.getUser())!));
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
}