class CategoryItem {
  final String? itemTitle;
  final String? subText1;
  final String? subText2;
  final String? subText3;

  CategoryItem({
    this.itemTitle,
    this.subText1,
    this.subText2,
    this.subText3,
  });

   factory CategoryItem.fromJson(Map<dynamic, dynamic> json) => CategoryItem(
        itemTitle: json['item_title'],
        subText1: json['sub_text1'],
        subText2: json['sub_text2'],
        subText3: json['sub_text3'],
      );
}
