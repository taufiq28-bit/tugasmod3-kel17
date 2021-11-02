import 'package:flutter/material.dart';
import 'package:tugasmod3_kel17/screen/profile.dart';
// ignore: unused_import
import 'package:tugasmod3_kel17/screens/profile.dart';

class Profiles extends StatelessWidget {
  const Profiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KELOMPOK 17'),
      ),
      body: Column(
        children: [
          Anggota(
            nama: "Reehan Putra Perdana",
            nim: "21120119130047",
            kelompok: "17",
          ),
          Anggota(
            nama: "PEGGY RAIHANNISA ZAKIYYAHANNAS",
            nim: "21120119130111",
            kelompok: "17",
          ),
          Anggota(
            nama: "Taufiqurrohman",
            nim: "21120119120005",
            kelompok: "17",
          ),
          Anggota(
            nama: "DAVA SAFGI INDRASWARA",
            nim: "21120119140135",
            kelompok: "17",
          )
        ],
      ),
    );
  }
}
