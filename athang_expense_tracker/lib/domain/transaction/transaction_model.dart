class TransactionModel {
  num id;
  String createdAt;
  String updatedAt;
  String title;
  String note;
  String? document;
  num amount;
  String type;

  TransactionModel({
    this.id = 1,
    this.createdAt = "",
    this.updatedAt = "",
    this.title = "",
    this.note = '',
    this.document = null,
    this.amount = 0,
    this.type = "EXPENSE",
  });
}