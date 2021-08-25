import 'package:get_it/get_it.dart';
import 'package:google_sheet_task/logic/vm/productList_vm.dart';

import 'logic/services/google_sheet_services.dart';
import 'logic/vm/productForm_vm.dart';

final sl = GetIt.I;

void setupServicesLocator() {
  sl.registerLazySingleton(() => GoogleSheetsServices());
  sl<GoogleSheetsServices>().configGoogleSheetsServices();

  sl.registerLazySingleton(() => ProductFormViewModel());
  sl.registerLazySingleton(() => ProductListViewModel());
}
