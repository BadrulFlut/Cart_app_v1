import 'dart:convert';

import 'package:apps_venturo_v3/models/order_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class OrderService {
  final String baseUrl = "https://tes-mobile.landa.id/api";
  final Dio dio = Dio();

  Future createOrderData(int total, int voucher, List<OrderItem> items) async {
    final nominalDiskon = voucher;
    final nominalPesanan = total;
    final data = {
      'nominal_diskon': nominalDiskon,
      'nominal_pesanan': nominalPesanan,
      'items': items
          .map((e) => {'id': e.id, 'harga': e.harga, 'catatan': e.catatan})
          .toList()
    };
    final response = await dio.post('$baseUrl/order',
        queryParameters: {'Content-Type': 'aplication/json'},
        data: jsonEncode(data));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.data);

      final id = responseData['id'];
      print(id);
      items.clear();
      return id;
    } else {
      final responseData = jsonDecode(response.data);
      final message = responseData['message'];
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> cancelOrder(String id) async {
    try {
      final response = await dio.post('$baseUrl/order/cancel/$id');

      print(response);

      if (response.statusCode == 200) {
        return {
          "status_code": 200,
          "message": response.data["message"],
        };
      } else if (response.statusCode == 204) {
        return {
          "status_code": 204,
          "message": 'Data tidak ditemukan',
        };
      } else {
        return {
          "status_code": 400,
          "message": 'Data gagal ditemukan',
        };
      }
    } on DioError catch (e) {
      return {
        "status_code": 400,
        "message": 'Terjadi kesalahan: ${e.message}',
      };
    }
  }
}
