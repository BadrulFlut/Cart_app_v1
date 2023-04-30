import 'dart:convert';

import 'package:apps_venturo_v3/models/menu_model.dart';
import 'package:dio/dio.dart';

class MenuService {
  static final Dio _dio = Dio();

  Future<List<Menu>> getMenu() async {
    try {
      final response = await _dio.get('https://tes-mobile.landa.id/api/menus');
      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data['datas'];
        List<Menu> dataList = jsonList.map((e) => Menu.fromJson(e)).toList();
        return dataList;
      } else {
        throw Exception('Filed to fecth data');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception('Filed to fecth data');
      } else {
        throw Exception('Data not found');
      }
    }
  }
}
