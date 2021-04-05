import 'package:barbers_store/infrastructure/model/category.model.dart';

class Categories {
  static const List<String> incomeCategories = [
    'Courses',
    'Sales',
    'Government'
  ];

  static const List<String> outcomeCategories = [
    'Courses',
    'Operating',
    'Withdraws'
  ];

  static const Category inCoursesSubCategory = Category(
      key: 'Courses',
      subCategory: [
        'Barbering courses',
        'Nails course',
        'Make up course',
        'Other'
      ]);

  static const Category inSalesSubCategory =
      Category(key: 'Sales', subCategory: ['Barcode reader', 'Other input']);

  static const Category inGovernmentSubCategory =
      Category(key: 'Government', subCategory: ['Grants', 'Tax refund']);

  static const Category outCoursesSubCategory = Category(
      key: 'Courses',
      subCategory: [
        'Barbering courses',
        'Nails course',
        'Make up course',
        'Other'
      ]);

  static const Category outOperatingSubCategory =
      Category(key: 'Operating', subCategory: ['Operating']);

  static const Category outWithdrawsSubCategory =
      Category(key: 'Withdraws', subCategory: ['Murad', 'Muath']);

  static List<Category> incomeSubCategories = [
    inCoursesSubCategory,
    inGovernmentSubCategory,
    inSalesSubCategory
  ];
  static List<Category> outcomeSubCategories = [
    outCoursesSubCategory,
    outOperatingSubCategory,
    outWithdrawsSubCategory
  ];

  static const String cartIncomeCategory = 'Sales';
  static const String cartIncomeSubCategory = 'Barcode reader';
}
