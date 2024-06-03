class AccountModel {
  num id;
  String title;
  String img;
  num openingBalance;

  AccountModel({
    required this.id,
    required this.title,
    required this.img,
    required this.openingBalance,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    // return switch (json) {
    //   {
    //   'id': int id,
    //   'title': String title,
    //   'img': String img,
    //   'openingBalance': num openingBalance,
    //   } =>
    //       AccountModel(
    //         img: img,
    //         title: title,
    //         openingBalance: openingBalance,
    //         id: id,
    //       ),
    //   _ => throw const FormatException('Format not supported.'),
    // };
    return AccountModel(
      id: json['id'],
      title: json['title'],
      img: json['img'],
      openingBalance: json['openingBalance']);
  }

}

