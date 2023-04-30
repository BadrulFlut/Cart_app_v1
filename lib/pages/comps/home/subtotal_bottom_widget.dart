import 'package:apps_venturo_v3/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtotalWidget extends StatefulWidget {
  int totalHarga;
  int totalPesanan;
  bool isOpen;
  String kode;
  int nominal;
  SubtotalWidget(
      {super.key,
      required this.totalHarga,
      required this.totalPesanan,
      required this.isOpen,
      required this.kode,
      required this.nominal});

  @override
  State<SubtotalWidget> createState() => _SubtotalWidgetState();
}

class _SubtotalWidgetState extends State<SubtotalWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        width: MediaQuery.of(context).size.width,
        height: 191,
        decoration: const BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
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
                      '(${widget.totalPesanan} Menu) :',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Text(
                  'Rp ${widget.totalHarga}',
                  style: GoogleFonts.montserrat(
                      fontSize: 14, fontWeight: FontWeight.w700, color: text),
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
                        widget.isOpen = true;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.kode == '' || widget.nominal == 0
                            ? Text('Input Voucher',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0x7F2E2E2E)))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.kode,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Rp ${widget.nominal}',
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
    );
  }
}
