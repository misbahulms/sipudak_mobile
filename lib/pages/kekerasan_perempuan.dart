import 'package:flutter/material.dart';
import 'package:sipudak/theme.dart';
// import 'package:sipudak/widget/my_header.dart';
import 'package:sipudak/widget/my_headerPr.dart';

class Perempuan extends StatelessWidget {
  const Perempuan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          MyHeaderPr(
              image: "assets/pana.png",
              texttop: "Bentuk Kekerasan",
              textbottom: "Perempuan"),
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
                child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Perlindungan Perempuan adalah segala upaya yang ditujukan untuk melindungi dan memberikan rasa aman kepada perempuan serta pemenuhan haknya melalui perhatian yang konsisten, terstruktur dan sistematis yang ditujukan untuk mencapai kesetaraan gender.",
                    style: boldTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "1. Fisik",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(
                      "Kekerasan fisik adalah perbuatan yang mengakibatkan rasa sakit atay luka berat (pasal 6 undang-undang nomor 23 tahun 2004 tentang penghapusan kekerasan dalam rumah tangga). Contoh : memukul, menampar, menjambak, menendang, menusuk, membakar, menyabet, menyulut dengan rokok, melempar benda kearah tubuh korban "),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "2. Psikis",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(
                      "Kekerasan Psikis adalah perbuatan yang mengakibatkan ketakukatan, hilangnya rasa percaya diri, hilangnya kemampuan untuk bertindak, rasa tidak berdaya dan/atau penderitaan psikis berat pada seseorang (pasal 7 dalam undang-undang nomor 23 tahun 2004 tentang penghapusan kekerasan dalam rumah tangga). Contoh: tindakan pengendalian, manipulasi, eksploitasi, kesewenangan, perendahan, dan penghinaan dalam bentuk pelarangan, pemaksaan dan isolasi sosial. "),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "3. Seksual",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(
                      "Kekerasan Seksual adalah perbuatan pemaksaan hubungan seksual melalui ancaman, intimidasi atau kekuatan fisik, memaksa hubungan seksual dengan orang lain. Contoh: perbuatan merendahkan, menghina, melecehkan, dan/atau menyerang tubuh atau fungsi reproduksi seseorang, karena ketimpangan relasi kuasa atau gender yang berakibat penderitaan psikis atau fisik."),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "4. Eksploitasi",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(
                      "Kekerasan Eksploitasi adalah perbuatan yang tujuannya untuk mengambil suatu keuntungan atau memanfaatkan sesuatu dengan berlebih dan sewenang-wenang. Perbuatan eksploitasi ini seringkali berdampak pada kerugian pada pihak lain, baik manusia maupun lingkungan. Contoh: merampas hak-hak perempuan atau anak."),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "5. Trafficking",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(
                      "Kekerasan Trafficking adalah perbuatan, perekrutan, pengangkutan, penampungan, pengiriman, pemindahan, atau penerimaan seseorang dengan ancaman kekerasan, penggunaan kekerasan, penculikan, penyekapan, pemalsuan, penipuan, penyalahgunaan kekuasaan, penjeratan utang atau memberi bayaran atau manfaat, sehingga memperoleh persetujuan dari orang yang memegang kendali atas orang lain tersebut."),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "6. Penelantaran",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(
                      "Kekerasan Penelantaran adalah perbuatan, ancaman untuk melakukan perbuatan, pemaksaan atau perampasan kemerdekaan secara melawan hukum dalam lingkungan rumah tangga(pasa 1 undang-undang PDKRT). KDRT tidak hanya dalam bentuk fisik, seksual dan psikologis, namun juga dalam bentuk penelantaran rumah tangga."),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
