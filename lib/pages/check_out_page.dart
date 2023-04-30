import 'package:apps_venturo_v3/helpers/colors.dart';
import 'package:apps_venturo_v3/models/menu_model.dart';
import 'package:apps_venturo_v3/pages/comps/check_out/subtotal_with_voucher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutPage extends StatelessWidget {
  List<Menu> listMenu = [];
  int nominal = 0;
  int totalHarga = 0;
  int totalPesanan = 0;
  String kode = '';
  int orderId = 1;
  CheckOutPage(
      {super.key,
      required this.listMenu,
      required this.nominal,
      required this.totalHarga,
      required this.totalPesanan,
      required this.kode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: ListView.builder(
              itemCount: listMenu.length,
              itemBuilder: (context, index) {
                final menu = listMenu[index];
                return menu.count == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 25),
                        child: Opacity(
                          opacity: 0.5,
                          child: Container(
                            width: 378,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                    spreadRadius: -1,
                                    color: Color.fromRGBO(46, 46, 46, 0.35),
                                  )
                                ]),
                            child: Container(
                              margin: const EdgeInsets.all(7),
                              child: Row(
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(menu.gambar),
                                        ),
                                        color: const Color(0xFFDFDFDF),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    width: 181,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(menu.nama,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          'Rp ${menu.harga}',
                                          style: GoogleFonts.montserrat(
                                              color: text,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 25),
                        child: Container(
                          width: 378,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 8,
                                  spreadRadius: -1,
                                  color: Color.fromRGBO(46, 46, 46, 0.35),
                                )
                              ]),
                          child: Container(
                            margin: const EdgeInsets.all(7),
                            child: Row(
                              children: [
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(menu.gambar),
                                      ),
                                      color: const Color(0xFFDFDFDF),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  width: 181,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(menu.nama,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        'Rp ${menu.harga}',
                                        style: GoogleFonts.montserrat(
                                            color: text,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 13,
                                            height: 13,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/icons/note.png'),
                                                    fit: BoxFit.cover)),
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          menu.catatan.isEmpty
                                              ? Text(
                                                  'Pembeli tidak ada catatan',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xFFAAAAAA)),
                                                )
                                              : Text(
                                                  menu.catatan,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xFFAAAAAA)),
                                                ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 22,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 36.5,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFA0A0A0),
                                              width: 1)),
                                    ),
                                    const SizedBox(
                                      width: 31,
                                    ),
                                    Text(
                                      menu.count.toString(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SubtotalVoucher(
              totalHarga: totalHarga,
              nominal: nominal,
              orderId: orderId.toString())
        ],
      ),
    );
  }
}
