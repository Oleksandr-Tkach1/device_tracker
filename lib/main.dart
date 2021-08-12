import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_bloc/authentication_bloc.dart';
import 'authentication_bloc/authentication_event.dart';
import 'authentication_bloc/authentication_state.dart';
import 'authentication_bloc/simple_bloc_delegate.dart';
import 'repository/user_repository.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

main() {
  Bloc.observer = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();

  //Под вопросом
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Authenticated) {
              return HomeScreen(name: state.displayName,);
            }
            },
        ),
      ),
    );
  }

   @override
   void dispose() {
     _authenticationBloc.close();
     super.dispose();
   }
}