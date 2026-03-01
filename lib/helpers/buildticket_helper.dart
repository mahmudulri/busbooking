import 'package:get/get.dart';

import '../controllers/customer_profile_controller.dart';

Map<String, dynamic>? buildTicket(
  int seatPriceId,
  CustomerProfileController controller,
) {
  final profile = controller.profileData.value.body?.profile;

  if (profile == null) {
    return null;
  }

  return {
    "first_name": profile.firstName,
    "last_name": profile.lastName,
    "national_id": profile.nationalId,
    "phone": profile.mobile,
    "birthday": "",
    "email": profile.email,
    "gender": profile.gender,
    "trip_seat_price_id": seatPriceId,
    "is_child": 0,
  };
}
