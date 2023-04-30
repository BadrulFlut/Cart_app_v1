import 'package:apps_venturo_v3/models/voucher_model.dart';
import 'package:dio/dio.dart';

class VoucherService {
  static final Dio _dio = Dio();

  Future<Voucher?> getVoucher(String kode) async {
    try {
      if (kode == null || kode.isEmpty) {
        throw Exception('Kode tidak boleh kosong');
      }
      final response = await _dio.get(
          'https://tes-mobile.landa.id/api/vouchers',
          queryParameters: {'kode': kode});
      if (response.statusCode == 200) {
        final data = response.data['datas'];
        return Voucher.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error while loading voucher');
      print(e);
      return null;
    }
  }
}
