import 'package:google_sheet_task/logic/models/product.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsServices {
  final String _credentials = r'''
  {
  "type": "service_account",
  "project_id": "sheetstask",
  "private_key_id": "ce37308e576c3435332461a1f05a9ed32872f1c4",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCKDsz4IoVhAgAk\n/nzfk+tZxpBL2E1TUHV1jRWEzHNNdndjV73/ZbrUYXw7ZFKBHu6raoPBOKathSmj\nuqSbn86TaR3kPsg7bk4cC9T8a/DOm5lLLIBGsM1q3xyNHT76HFNQcJv11a+lqnB/\njZlvdgqC4vCZlgEiPbWTzoJ15otV8dtWCouc2et05JzKvmubB47gxIwNUCB7BMAK\nxv+YBV+/C0wesy/RWQctxBeFCMkjZ/OFjg47g3StZcjrzFZPT/5JKzDUxd9Gv3lv\nyINZ/QakrrjoPlDLRhQv58I5HfU+Xhvzo11VzRJrkyVbtExJolAtr9Xbp09g243D\nXFOejlnVAgMBAAECggEACbvg6kbe0hfmxDT4P3hJsf78yggybYMhAPyFTaNvpsDJ\nSqUTVZhJ27MS5AofAhEZAVeFeiBhKh9XL/7XH8zc7wpMi/z8N6p/kd0os3J13E9e\nt8znr3RES3p3JCDxgYdxPVzvNh5On9bcTzX/4Tq4o4FWNvH7WvtwW79F9gOfA9xq\n1aD3vXHuKzXKGzJiGaeRTh02hDenPg7nldr3J4xltZCJmQ0ienSf0F33sqrMM6VM\nRF+4uE0I+gHs/4FBfE+PkYtSijsYm4kNLpniaBEfrLEPWZx4zkr6pO0DwCu3cooF\n5PZqwoZmmXnD4LpEdM9R16qd9Hh4JiU/Ppa10T6uoQKBgQDBu8xcaVTXm5+VqkO2\nCto0z9XEzxBvI/E8jWHWVSK5AnQ3F00Z7OK16ZrXk1BvzbtI4rFM6JIbQ/PDNJMX\nJ/sovUfAk0jNi4La1QnoADZQ1hwfD/H2q2f3htbC62wK9RAYerv2+ZHCXNzG5gzq\nmyzdKtkLesoQLNuTx0dZzZKIYQKBgQC2bg6Em9GqM+HhvrVyZlNG4wt4LJR13jG2\nuPawQxAC8Sc61gXA0TfSlucVAAATD154mTH8gZdYxby0SsYCsTYQnP/613R2kfB/\np2Lt9UnnONzdiXh/luW/QemVKAX0MG5GdFRu2phoyZ6RZwF4JI+lZnRcmAyRUReD\nw+8rQ+319QKBgEXXN+MQrd9UYQGJcgOMggGL81qR8zC92lej+GNWKcBcnBzIL6lq\n9ofyATo6B0Nm/V9XKee56AIgSx5SM7yjUy3qnpVUA2jmJHRTXNDgUrRtm5GvI+Fz\nBXX8jCuUx0xj8DuC84QjkGJrK8QgZwOkkVXh/oDe8T1HjpkFvDkpnOvBAoGAFagT\nCSMGTNJD6mydVatYD348ilOgfC2YcTyb7GjJqc++/HkTzcQIgHNxk0iguaKFcIOf\nL36i3OL8d9q4jvFCnc5FhR22say5hC32zJDl6RETBymeqGbdd0r308Egk9B8Btkg\nfNhuZ2In9NLplb2hX909yxAxzb52sCm+ZsB1q1ECgYBXRp2sllWbkUsccwjq+V+B\nngQiWA4mOL/6skSHOHtR4r96MQkhQf2yJBytE8zHoz2JV0JJN4B9hGP34ktK/XhR\nQY5oBVPx5VRY/5oqcS+uJtAUOAdQq3spvJKsCTHCi/kFOK+N1gi+HUqufCJ/SJIh\naAiKwufpRCY9h5Gpm8KQJw==\n-----END PRIVATE KEY-----\n",
  "client_email": "sheetstask@sheetstask.iam.gserviceaccount.com",
  "client_id": "103144470575988811798",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sheetstask%40sheetstask.iam.gserviceaccount.com"
}
''';

  final String _spreedSheetId = '1lyNyKjS6f4Mmkl5v5agmU4THzCKzip1A1_2NOB6xPFI';

  GSheets gsheets;

  Worksheet productsWorkSheet;

  Spreadsheet spreadsheet;

  int nextProductId;

  void configGoogleSheetsServices() async {
    gsheets = GSheets(_credentials);
    spreadsheet = await gsheets.spreadsheet(_spreedSheetId);
    productsWorkSheet = spreadsheet.worksheetByTitle('Products');
    print('fitch product work sheet by title : ${productsWorkSheet.title}');
    nextProductId = await getSheetRowNumber();
  }

  Future<int> getSheetRowNumber() async {
    var rowsNumber = await productsWorkSheet.values.allRows();
    return rowsNumber.length;
  }

  Future<bool> addProduct(Product product) async {
    product.id = await getSheetRowNumber();
    bool isSuccess = await productsWorkSheet.values.map.appendRow(
      // '42',
      product.toGsheets(),
      appendMissing: true,
    );
    return isSuccess;
  }

  Future<List<Product>> getAllProducts() async {
    //skip first row because its about columns titles
    final products = await productsWorkSheet.values?.map?.allRows(
      fromRow: 2,
    );
    return products?.map((json) => Product.fromGsheets(json))?.toList() ?? [];
  }

  Future<bool> deleteProduct(int productId) async {
    final index = await productsWorkSheet.values.rowIndexOf(productId);
    if (index > 0) {
      return productsWorkSheet.deleteRow(index);
    }
    return false;
  }
}
