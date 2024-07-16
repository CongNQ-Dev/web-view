import '../../utils/http.dart';
import '../entities/customer.dart';

class CustomerAPI {
  static Future<CustomerItem> login({
    ExternalLogin? params,
  }) async {
    var response = await HttpUtil()
        .post('api/Customer/ExternalLogin', data: params?.toJson());
    return CustomerItem.fromJson(response);
  }
}
