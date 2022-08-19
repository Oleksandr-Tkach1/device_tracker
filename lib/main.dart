import 'dart:async';
import 'package:device_tracker/%20home_page/home_screen.dart';
import 'package:device_tracker/google_map/bloc_google_map/google_map_bloc.dart';
import 'package:device_tracker/google_map/bloc_google_map/google_map_event.dart';
import 'package:device_tracker/google_map/todos_repository.dart';
import 'package:device_tracker/helper/device_inf.dart';
import 'package:device_tracker/home_screens/splash_screen.dart';
import 'package:device_tracker/login_system/login/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_bloc/authentication_bloc.dart';
import 'authentication_bloc/authentication_event.dart';
import 'authentication_bloc/authentication_state.dart';
import 'authentication_bloc/simple_bloc_delegate.dart';
import 'repository/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DeviceInfo();
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: SimpleBlocDelegate(),
  );
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GoogleMapBloc(
            locationRepository: LocationRepository(),
          )..add(LoadGoogleMap()),
        ),
      ],
      child: MaterialApp(
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen(userRepository: _userRepository);
            }
            if (state is Authenticated) {
              return HomeScreen(
                name: state.displayName,
              );
            } else
              return Container(); // it has to return something, can't return null/nothing
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
