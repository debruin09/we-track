import 'package:get_it/get_it.dart';
import 'package:we_track/blocs/forgotPasswordBloc/forgotpassword_bloc.dart';
import 'package:we_track/blocs/notificationBloc/notification_bloc.dart';
import 'package:we_track/repositories/firestore_service.dart';
import 'package:we_track/repositories/local_notification_service.dart';
import 'package:we_track/repositories/user_repository.dart';

final locator = GetIt.instance;

/// The dependancy injection locator which will inject these class where they are needed
void setupLocator() {
  ///[Registered Repositories]
  locator.registerFactory<UserRepository>(() => UserRepository());
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());
  locator.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());

  ///[Registered Blocs]
  locator.registerFactory<NotificationBloc>(() => NotificationBloc(locator()));
  locator.registerFactory<ForgotPasswordBloc>(
      () => ForgotPasswordBloc(userRepository: locator()));
}
