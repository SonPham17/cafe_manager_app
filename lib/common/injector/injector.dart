import 'package:cafe_manager_app/common/blocs/loading/loading_cubit.dart';
import 'package:cafe_manager_app/common/blocs/snackbar/snackbar_cubit.dart';
import 'package:cafe_manager_app/features/authentication/login/data/datasources/login_local_datasource.dart';
import 'package:cafe_manager_app/features/authentication/login/data/datasources/login_remote_datasource.dart';
import 'package:cafe_manager_app/features/authentication/login/data/repositories/login_repository_impl.dart';
import 'package:cafe_manager_app/features/authentication/login/domain/usecases/login_usecase.dart';
import 'package:cafe_manager_app/features/authentication/login/presentation/bloc/login_cubit.dart';
import 'package:cafe_manager_app/features/authentication/splash/presentation/bloc/splash_cubit.dart';
import 'package:cafe_manager_app/features/main_home/data/datasources/main_home_remote_datasource.dart';
import 'package:cafe_manager_app/features/main_home/data/repositories/main_home_repository_impl.dart';
import 'package:cafe_manager_app/features/main_home/domain/usecases/main_home_usecase.dart';
import 'package:cafe_manager_app/features/main_home/presentation/bloc/main_home_cubit.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer kiwiContainer;

  static void setup() {
    kiwiContainer = KiwiContainer();
    _$Injector()._configure();
  }

  static final resolve = kiwiContainer.resolve;

  void _configure() {
    _configureCubits();
    _configureUseCases();
    _configureRepositories();
    _configureRemoteDataSources();
    _configureLocalDataSources();
  }

  // ============CUBITS==============
  @Register.singleton(SnackBarCubit)
  @Register.factory(SplashCubit)
  @Register.singleton(MainHomeCubit)
  @Register.singleton(LoadingCubit)
  @Register.factory(LoginCubit)
  void _configureCubits();

  // ============USE CASES============
  @Register.factory(LoginUseCase)
  @Register.factory(MainHomeUseCase)
  void _configureUseCases();

  // ============REPOSITORIES==========
  @Register.factory(LoginRepositoryImpl)
  @Register.factory(MainHomeRepositoryImpl)
  void _configureRepositories();

  // ============REMOTE DATA SOURCE====
  @Register.factory(LoginRemoteDataSource)
  @Register.factory(MainHomeRemoteDataSource)
  void _configureRemoteDataSources();

  // ============LOCAL DATA SOURCE=====
  @Register.factory(LoginLocalDataSource)
  void _configureLocalDataSources();
}
