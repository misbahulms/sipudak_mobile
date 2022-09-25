import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:sipudak/widget/my_header.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/my_headerPp.dart';

import 'package:native_pdf_view/native_pdf_view.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../utils/pallete.dart';

class PanduanAplikasiPage extends StatefulWidget {
  @override
  _PanduanAplikasiPageState createState() => _PanduanAplikasiPageState();
}

class _PanduanAplikasiPageState extends State<PanduanAplikasiPage> {
  int _actualPageNumber = 1, _allPagesCount = 0;
  bool isSampleDoc = true;
  PdfController? _pdfController;

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/Panduan_Sipudak.pdf'),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                    height: 450,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: yellowColor,
                    ),
                    child:
                        //  AppBar(
                        // elevation: 0.0,
                        // backgroundColor: Colors.white,
                        // title:
                        Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 60, left: 10),
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => Beranda(),
                                    //     ));
                                  },
                                  icon: Icon(Icons.arrow_back_outlined),
                                  color: Colors.white,
                                  iconSize: 30)),
                          // ClipRRect(
                          //     borderRadius: BorderRadius.circular(100),
                          //     child: CachedNetworkImage(
                          //       height: 45,
                          //       width: 45,
                          //       imageUrl:
                          //           "http://sijelita.bwskal1.or.id/avatar/avatar-7etRz.JPG",
                          //       // imageBuilder: (context, imageProvider) => Container(
                          //       //   decoration: BoxDecoration(
                          //       //     image: DecorationImage(
                          //       //         image: imageProvider,
                          //       //         fit: BoxFit.cover,
                          //       //         colorFilter: ColorFilter.mode(
                          //       //             Colors.red, BlendMode.colorBurn)),
                          //       //   ),
                          //       // ),
                          //       placeholder: (context, url) =>
                          //           CircularProgressIndicator(),
                          //       errorWidget: (context, url, error) => Icon(Icons.error),
                          //     )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.navigate_before,
                                    color: Colors.black),
                                onTap: () {
                                  _pdfController!.previousPage(
                                    curve: Curves.ease,
                                    duration: Duration(milliseconds: 100),
                                  );
                                },
                              ),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '$_actualPageNumber/$_allPagesCount',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                child: Icon(Icons.navigate_next,
                                    color: Colors.black),
                                onTap: () {
                                  _pdfController!.nextPage(
                                    curve: Curves.ease,
                                    duration: Duration(milliseconds: 100),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )))),
        body: Container(
          decoration: BoxDecoration(
              // color: Pallete.whiteF7,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: PdfView(
            documentLoader: Center(child: CircularProgressIndicator()),
            pageLoader: Center(child: CircularProgressIndicator()),
            controller: _pdfController!,
            onDocumentLoaded: (document) {
              setState(() {
                _actualPageNumber = 1;
                _allPagesCount = document.pagesCount;
              });
            },
            onPageChanged: (page) {
              setState(() {
                _actualPageNumber = page;
              });
            },
          ),
        ),
      );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// class Panduan extends StatelessWidget {
//   const Panduan({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: <Widget>[
//           MyHeaderPp(
//               image: "assets/guide.png",
//               texttop: "Panduan Pelaporan",
//               textbottom: ""),
//           Card(
//             margin: EdgeInsets.all(20),
//             child: Container(
//                 child: Column(
//               children: <Widget>[
//                 ListTile(
//                   title: Text(
//                     "Sebelum melakukan pelaporan sebaiknya pelajari terlebih dahulu cara-cara pelaporan",
//                     style: boldTextStyle,
//                   ),
//                   subtitle: Text(""),
//                 ),
//                 ListTile(
//                   title: Text(
//                     "1. Pahami dulu bentuk kekerasan perempuan atau anak",
//                     style: boldTextStyle,
//                   ),
//                   subtitle: Text(""),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ListTile(
//                   title: Text(
//                     "2. Silahkan buka halaman Perempuan untuk melihat bentuk kekerasan terhadap perempuan",
//                     style: boldTextStyle,
//                   ),
//                   subtitle: Text(""),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 ListTile(
//                   title: Text(
//                     "3. Silahkan buka halaman Anak untuk melihat bentuk kekerasan terhadap anak",
//                     style: boldTextStyle,
//                   ),
//                   subtitle: Text(""),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 ListTile(
//                   title: Text(
//                     "4. Kemudian buka halaman peraturan untuk mengetahui hukum apa saja yang terkait kekerasan terhadap perempuan dan anak",
//                     style: boldTextStyle,
//                   ),
//                   subtitle: Text(""),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 ListTile(
//                   title: Text(
//                     "5. Silahkan lakukan pelaporan pada halaman Laporkan untuk melakukan pelaporan tindak kekerasan yang di alami atau yang terlihat",
//                     style: boldTextStyle,
//                   ),
//                   subtitle: Text(""),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//               ],
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }
