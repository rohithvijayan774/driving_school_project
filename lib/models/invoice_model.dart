class InvoiceModel {
  String invoiceID;
  String invoiceUserName;
  String invoiceCourseName;
  String invoiceDate;
  double invoicePrice;
  String dueDate;

  InvoiceModel({
    required this.invoiceID,
    required this.invoiceUserName,
    required this.invoiceCourseName,
    required this.invoiceDate,
    required this.invoicePrice,
    required this.dueDate,
  });

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      invoiceID: map['invoiceID'],
      invoiceUserName: map['invoiceUserName'],
      invoiceCourseName: map['invoiceCourseName'],
      invoiceDate: map['invoiceDate'],
      invoicePrice: map['invoicePrice'],
      dueDate: map['dueDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoiceID': invoiceID,
      'invoiceUserName': invoiceUserName,
      'invoiceCourseName': invoiceCourseName,
      'invoiceDate': invoiceDate,
      'invoicePrice': invoicePrice,
      'dueDate': dueDate,
    };
  }
}
