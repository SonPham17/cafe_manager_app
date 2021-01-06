// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureCubits() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => SnackBarCubit());
    container.registerFactory((c) => SplashCubit());
    container.registerSingleton((c) => MainHomeCubit(
        mainHomeUseCase: c<MainHomeUseCase>(),
        snackBarCubit: c<SnackBarCubit>(),
        loadingCubit: c<LoadingCubit>()));
    container.registerSingleton((c) => LoadingCubit());
    container.registerFactory((c) => LoginCubit(
        loginUseCase: c<LoginUseCase>(), snackBarCubit: c<SnackBarCubit>()));
    container.registerFactory((c) => MenuCubit(
        menuUseCase: c<MenuUseCase>(),
        loadingCubit: c<LoadingCubit>(),
        snackBarCubit: c<SnackBarCubit>()));
  }

  @override
  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => LoginUseCase(loginRepository: c<LoginRepositoryImpl>()));
    container.registerFactory((c) =>
        MainHomeUseCase(mainHomeRepository: c<MainHomeRepositoryImpl>()));
    container.registerFactory(
        (c) => MenuUseCase(menuRepository: c<MenuRepositoryImpl>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => LoginRepositoryImpl(
        localDataSource: c<LoginLocalDataSource>(),
        remoteDataSource: c<LoginRemoteDataSource>()));
    container.registerFactory((c) => MainHomeRepositoryImpl(
        mainHomeRemoteDataSource: c<MainHomeRemoteDataSource>()));
    container.registerFactory((c) =>
        MenuRepositoryImpl(menuRemoteDataSource: c<MenuRemoteDataSource>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => LoginRemoteDataSource());
    container.registerFactory((c) => MainHomeRemoteDataSource());
    container.registerFactory((c) => MenuRemoteDataSource());
  }

  @override
  void _configureLocalDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => LoginLocalDataSource());
  }
}
