import 'package:barbers_store/infrastructure/model/category.model.dart';

class Categories {
  static const List<String> incomeCategories = ['in1', 'in2'];
  static const List<String> outcomeCategories = ['out1', 'out2'];

  static const Category in1SubCategory =
      Category(key: 'in1', subCategory: ['sub1-1', 'sub1-2']);

  static const Category in2SubCategory =
      Category(key: 'in2', subCategory: ['sub2-1', 'sub2-2']);

  static const Category out1SubCategory =
      Category(key: 'out1', subCategory: ['sub1-1', 'sub1-2']);

  static const Category out2SubCategory =
      Category(key: 'out2', subCategory: ['sub2-1', 'sub2-2']);

  static List<Category> incomeSubCategories = [in1SubCategory, in2SubCategory];
  static List<Category> outcomeSubCategories = [
    out1SubCategory,
    out2SubCategory
  ];

  static const String cartIncomeCategory = 'in1';
  static const String cartIncomeSubCategory = 'sub1-1';
}
