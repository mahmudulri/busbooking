class ApiEndPoints {
  static String baseUrl = "https://api.milliekit.com/api/v1/";

  static OtherendPoints otherendpoints = OtherendPoints();
}

class OtherendPoints {
  final String signin = "auth";
  final String customerprofile = "customer/wallets/profile";
  final String customerbalance = "customer/wallets/balance";
}
