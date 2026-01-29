class ApiEndPoints {
  static String baseUrl = "https://api.milliekit.com/api/v1/";

  static OtherendPoints otherendpoints = OtherendPoints();
}

class OtherendPoints {
  final String signin = "auth";
  final String customerprofile = "customer/profile";
  final String customerwallet = "customer/wallets/balance";
  final String cities = "web/location/cities";
}
