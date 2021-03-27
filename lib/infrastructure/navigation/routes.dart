class Routes {
  static Future<String> get initialRoute async {
    return BALANCE;
  }

  static const BALANCE = '/home';
  static const PRODUCT_LIST = '/product-list';
  static const STORE = '/store';
  static const INCOME_FORM = '/income-form';
  static const OUTCOME_FORM = '/outcome-form';
}
