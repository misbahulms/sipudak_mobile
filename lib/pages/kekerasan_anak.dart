import 'package:flutter/material.dart';
import 'package:sipudak/theme.dart';
// import 'package:sipudak/widget/my_header.dart';
import 'package:sipudak/widget/my_headerAn.dart';

class Anak extends StatelessWidget {
  const Anak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          MyHeaderAn(
              image: "assets/sad-little.png",
              texttop: "Bentuk Kekerasan",
              textbottom: "Anak"),
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
                child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Perlindungan Anak adalah segala kegiatan untuk menjamin dan melindungi anak dan haknya agar dapat hidup, tumbuh, berkembang dan berpartisipasi secara optimal sesuai dengan harkat dan martabat kemanusiaan, serta mendapat perlindungan dari kekerasan dan diskriminasi.",
                    style: boldTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "1. Hukum Menelantarkan Anak dan Sanksi Pidananya",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(
                      "Pasal 59 UU No. 23 Tahun 2022 tentang Perlindungan Anak. Pemerintah dan lembaga negara lainnya berkewajiban dan bertanggung jawab memberikan perlindungan hukum kepada anak dalam situasi darurat, anak yang berhadapan dengan hukum, anak dari kelompok minoritas, dan terisolasi, anak tereksploitasi secara ekonomi dan/atau seksual, anak yang diperdagangkan, anak yang menjadi penyalahgunaan narkotika, alkohol, psikotropika, dan zat adiktif lainnya, anak korban penculikan penjualan dan perdagangan, anak korban kekerasan baik fisik dan/atau mental, anak yang menyandang cacat, dan anak korban pelaku penelantaran. Seorang anak dikatakan terlantar apabila anak tersebut tidak terpenuhi kebutuhan dasarnya dengan wajar, baik secara rohani, jasmani, maupun sosial. Anak yang ditelantarkan bukan disebabkan oleh ketidakhadiran orang tua, melainkan hak yang seharusnya dimiliki oleh anak tidak terpenuhi karena suatu alasan dari kedua orang tua. Menelantarkan anak dikategorikan sebagai suatu tindakan kekerasan dan merupakan delik dengan perbuatan dilarang oleh peraturan hukum pidana Indonesia. Bagi seseorang yang menelantarkan anak, maka akan dikenakan sanksi pidana."),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "2. Penganiayaan Anak ",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(
                      "Keberadaan siswa di sekolah dilindungi Undang-Undang Nomor 35 Tahun 2002 tentang Perlindungan Anak. Pasal 54 ayat (1) UU35/2014 menyatakan, Anak di dalam dan dilingkungan satuan pendidikan wajib mendapatkan perlindungan dari tindak kekerasan fisik, psikis, kejahatan seksual, dan kejahatan lainnya yang dilakukan oleh pendidik, tenaga kependidikan, sesama peserta didik, dan/atau pihak lain. Kemudian ayat (2) menyatakan, Perlindungan sebagaimana dimaksud pada ayat (1) dilakukan oleh pendidik, tenaga kependidikan, aparat pemerintah, dan/atau Masyarakat. Selain itu, pasal 76C UU No.35 Tahun 2014 juga secara tegas mengatur setiap orang dilarang menempatkan, membiarkan, melakukan, menyuruh melakukan, atau turut serta melakukan kekerasan terhadap anak. Pasal 80 UU 35/2014 mengatur mengenai pemberian sanksi bagi yang melanggarnya. Pasal 80 ayat (1) menyatakan, setiap Orag yang melanggar ketentuan sebagaimana dumaksud dalam Pasal 76C, dipidana dengan penjara paling lama 3 (tiga) tahun 6 (enam) bulan dan/atau denda paling banyak Rp72.000.000 (tujuh puluh dua juta rupiah."),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
