import 'package:apps_venturo_v3/helpers/colors.dart';
import 'package:apps_venturo_v3/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMenu extends StatefulWidget {
  Menu menu;
  VoidCallback increment;
  VoidCallback decrement;
  CardMenu(
      {super.key,
      required this.menu,
      required this.decrement,
      required this.increment});

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
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
                    color: const Color(0xFFDFDFDF),
                    image: DecorationImage(
                      image: NetworkImage(widget.menu.gambar),
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                width: 181,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.menu.nama,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            fontSize: 23, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Rp ${widget.menu.harga}',
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
                                  image: AssetImage('assets/icons/note.png'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Tambahkan catatan untuk penjual',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700)),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              widget.menu.catatan = value;
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: text,
                                            minimumSize: const Size(140, 50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Tambah catatan",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: widget.menu.catatan == ''
                              ? Text(
                                  'Tambahkan Catatan',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFAAAAAA)),
                                )
                              : Text(
                                  widget.menu.catatan,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFAAAAAA)),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.decrement,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/remove.png'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Text(
                    widget.menu.count.toString(),
                    style: GoogleFonts.montserrat(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    onTap: widget.increment,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/add.png'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
