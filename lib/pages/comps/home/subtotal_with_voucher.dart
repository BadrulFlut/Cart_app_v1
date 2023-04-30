import 'package:apps_venturo_v3/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtotalVoucher extends StatefulWidget {
  int totalHarga;
  int nominal;
  VoidCallback buttonNav;
  SubtotalVoucher(
      {super.key,
      required this.totalHarga,
      required this.nominal,
      required this.buttonNav});

  @override
  State<SubtotalVoucher> createState() => _SubtotalVoucherState();
}

class _SubtotalVoucherState extends State<SubtotalVoucher> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          height: 66,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 20.0,
                offset: Offset(0.0, 1.0),
                spreadRadius: -1.0,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 11),
                width: 35,
                height: 30,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icons/cart.png'),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 9,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pembayaran',
                    style: GoogleFonts.montserrat(
                        color: const Color(0xB92E2E2E),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                      'Rp ${widget.totalHarga - widget.nominal < 0 ? 0 : widget.totalHarga - widget.nominal}',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: text))
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: text,
                    minimumSize: const Size(182, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: widget.buttonNav,
                  child: Text(
                    "Pesan Sekarang",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
