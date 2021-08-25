class Product {
  int id;
  final String name;
  final String ownerMobileNumber;
  final int modelNumber;
  final DateTime purchesDate;
  final String email;

  Product({
    this.id,
    this.name,
    this.ownerMobileNumber,
    this.modelNumber,
    this.email,
    this.purchesDate,
  });

  factory Product.fromGsheets(Map<String, dynamic> json) {
    DateTime time;
    var jsonDateTime = json['purchesDate'];
    if (jsonDateTime != null) {
      int number = int.tryParse(jsonDateTime);
      if (number != null) {
        time = DateTime.fromMillisecondsSinceEpoch(number);
      }
    }
    return Product(
      id: int.tryParse(json['id'] ?? ''),
      name: json['name'],
      purchesDate: time,
      email: json['email'],
      modelNumber: int.tryParse(json['modelNumber']),
      ownerMobileNumber: json['ownerMobileNumber'],
    );
  }

  Map<String, dynamic> toGsheets() {
    return {
      'id': id,
      'name': name,
      'purchesDate': this.purchesDate != null
          ? this.purchesDate?.millisecondsSinceEpoch
          : null,
      'email': this.email,
      'modelNumber': this.modelNumber,
      'ownerMobileNumber': this.ownerMobileNumber,
    };
  }

  @override
  String toString() =>
      'Product{id: $id, name: $name, purchesDate :$purchesDate, email : $email , modelNumber : $modelNumber, ownerMobileNumber , $ownerMobileNumber}';
}
