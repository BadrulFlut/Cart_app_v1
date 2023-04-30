import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:apps_venturo_v3/helpers/colors.dart';
import 'package:apps_venturo_v3/models/menu_model.dart';
import 'package:apps_venturo_v3/models/order_model.dart';
import 'package:apps_venturo_v3/pages/check_out_page.dart';
import 'package:apps_venturo_v3/pages/comps/home/menu_card.dart';
import 'package:apps_venturo_v3/pages/comps/home/subtotal_with_voucher.dart';
import 'package:apps_venturo_v3/services/menu_service.dart';
import 'package:apps_venturo_v3/services/order_service.dart';
import 'package:apps_venturo_v3/services/voucher_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int orderId = 0;
  bool isOpen = false;
  bool isDone = false;
  String kode = '';
  int nominal = 0;
  int totalPes = 0;
  int totalHar = 0;

  final MenuService _menuService = MenuService();
  final OrderService _orderService = OrderService();

  List<Menu> _menuList = [];
  List<OrderItem> items = [];

  TextEditingController controllerVoucher = TextEditingController();

  @override
  void initState() {
    _fecthMenuList();
    super.initState();
  }

  @override
  void dispose() {
    controllerVoucher.dispose();
    super.dispose();
  }

  void _incrementMenuCount(int index) {
    setState(() {
      _menuList[index].count++;
    });
  }

  void _decrementMenuCount(int index) {
    if (_menuList[index].count > 0) {
      setState(() {
        _menuList[index].count--;
      });
    }
  }

  void _fecthMenuList() async {
    final menuList = await _menuService.getMenu();
    setState(() {
      _menuList = menuList;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalHarga = 0;
    int totalPesanan = 0;
    for (var i = 0; i < _menuList.length; i++) {
      totalHarga += _menuList[i].count * _menuList[i].harga;
      totalPesanan += _menuList[i].count;
    }
    totalPes = totalPesanan;
    totalHar = totalHarga;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: ListView.builder(
              itemCount: _menuList.length,
              itemBuilder: (context, index) {
                final menu = _menuList[index];
                return CardMenu(
                  menu: menu,
                  decrement: () {
                    _decrementMenuCount(index);
                  },
                  increment: () {
                    _incrementMenuCount(index);
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              width: MediaQuery.of(context).size.width,
              height: 191,
              decoration: const BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total Pesanan ',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '($totalPesanan Menu) :',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Text(
                        'Rp $totalHarga',
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: text),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 19),
                    width: 383,
                    height: 0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(46, 46, 46, 0.25),
                        width: 0.5,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 22,
                            height: 17.33,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/icons/voucher.png'),
                            )),
                          ),
                          const SizedBox(
                            width: 11.89,
                          ),
                          Text(
                            'Voucher',
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              isOpen = true;
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              kode == '' || nominal == 0
                                  ? Text('Input Voucher',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0x7F2E2E2E)))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          kode,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Rp $nominal',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFFD81D1D)),
                                        )
                                      ],
                                    ),
                              const SizedBox(
                                width: 6.38,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0x7F2E2E2E),
                                size: 11.0,
                              ),
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          SubtotalVoucher(
            totalHarga: totalHarga,
            nominal: nominal,
            buttonNav: () async {
              if (isDone == false) {
                sendOrderData();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CheckOutPage(
                            listMenu: _menuList,
                            kode: kode,
                            nominal: nominal,
                            totalHarga: totalHarga,
                            totalPesanan: totalPesanan,
                          )),
                );
              }
            },
          ),
          AnimatedPositioned(
            bottom: 0,
            curve: Curves.linear,
            height: isOpen ? 191 : 0,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 50),
            child: Container(
              padding: const EdgeInsets.only(top: 27, left: 27, right: 27),
              decoration: const BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 1),
                      blurRadius: 20,
                      spreadRadius: -1,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: isOpen == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 19.29,
                              height: 15,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/icons/voucher.png'))),
                            ),
                            const SizedBox(
                              width: 10.71,
                            ),
                            Text(
                              'Punya kode voucher ?',
                              style: GoogleFonts.montserrat(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          'Masukan kode voucher disini',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        TextFormField(
                          controller: controllerVoucher,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                controllerVoucher.clear();
                              },
                              icon: const Icon(
                                Icons.cancel,
                                size: 13.0,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: text,
                            minimumSize: const Size(377, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isOpen = false;
                            });
                            final voucherService = VoucherService();
                            final voucher = await voucherService
                                .getVoucher(controllerVoucher.text);
                            if (voucher != null) {
                              setState(() {
                                nominal = voucher.nominal;
                                kode = voucher.kode;
                              });
                            }
                          },
                          child: Text(
                            "Validasi Voucher",
                            style: GoogleFonts.montserrat(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          )
        ],
      ),
    );
  }

  void sendOrderData() async {
    final url = 'https://tes-mobile.landa.id/api/order';
    final nominalDiskon = nominal;
    final nominalPesanan = totalHar;
    final data = {
      'nominal_diskon': nominalDiskon,
      'nominal_pesanan': nominalPesanan,
      'items': _menuList
          .map((item) =>
              {'id': item.id, 'harga': item.harga, 'catatan': item.catatan})
          .toList(),
    };
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final message = responseData['message'];
      final id = responseData['id']; // contoh id response
      print(data);
      setState(() {
        items.clear();
        isDone = true;
      });
    } else {
      final responseData = jsonDecode(response.body);
      final message = responseData['message'];
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Order Gagal'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      setState(() {
        isDone = isDone;
      });
    }
  }
}
