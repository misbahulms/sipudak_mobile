import 'package:flutter/material.dart';
import 'package:sipudak/pages/beranda.dart';
import 'package:sipudak/pages/profil.dart';
import 'package:sipudak/theme.dart';
import 'dart:io';
import 'package:dio/dio.dart';

import './network/api/url_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;
  bool _isLoading = false;
  var _jumlahKasus = 0;

  final _pageList = [
    Beranda(),
    Profil(),
  ];

  onTappedItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profil"),
        ],
        currentIndex: _selectIndex,
        onTap: onTappedItem,
        unselectedItemColor: grey35Color,
      ),
    );
  }
}
