import 'package:get_it/get_it.dart';
import 'package:parking_management_app/features/parking_mgmt/data/data_sources/remote_datasource.dart';
import 'package:parking_management_app/features/parking_mgmt/data/repositories/slot_repository_impl.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/get_slot_usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/release_slot_usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/cubit/parking_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

// Dependencies injection
Future<void> init() async {
  sl
    ..registerFactory(
      () => ParkingCubit(getSlotUsecase: sl(), releaseSlotUsecase: sl()),
    )
    ..registerLazySingleton(() => GetSlotUsecase(sl()))
    ..registerLazySingleton(() => ReleaseSlotUsecase(sl()))
    ..registerLazySingleton<SlotRepository>(() => SlotRepositoryImpl(sl()))
    ..registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl()))
    ..registerLazySingleton<http.Client>(() => http.Client());
}
