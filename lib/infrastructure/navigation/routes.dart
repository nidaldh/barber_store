class Routes {
  static Future<String> get initialRoute async {
    return BALANCE;
  }

  static const BALANCE = '/home';
  static const PRODUCT_LIST = '/product-list';
  static const STORE = '/store';
  static const INCOME_FORM = '/income-form';
  static const INCOME_LIST = '/income-list';
  static const OUTCOME_FORM = '/outcome-form';
  static const OUTCOME_LIST = '/outcome-list';
  static const CART_HOME = '/cart';
}
