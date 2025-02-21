import 'dart:convert';
import 'package:dunyaulkeleri/favoriler.dart';
import 'package:dunyaulkeleri/ortak_liste.dart';
import 'package:dunyaulkeleri/ulke.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'ulke_detay_sayfasi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final String _apiUrl =
      "https://restcountries.com/v3.1/all?fields=name,flags,cca2,capital,region,languages,population";

  List<Ulke> _butunUlkeler = [];

  List<String> _favoriUlkelerKodlari = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((AnaSayfaState) {
      _favorileriCihazHafizasindanCek().then((value) {
        _ulkeleriInternettenCek();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Tüm Ülkeler"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              _favorilerSayfasiniAc(context);
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ))
      ],
    );
  }

  Widget _buildBody() {
    return _butunUlkeler.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : OrtakListe(_butunUlkeler, _favoriUlkelerKodlari);
  }

  void _ulkeleriInternettenCek() async {
    Uri uri = Uri.parse(_apiUrl); //API'ye bağlanma
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponce =
        jsonDecode(response.body); //Yanıtı json olarak çözümler

    for (int i = 0; i < parsedResponce.length; i++) {
      Map<String, dynamic> ulkeMap = parsedResponce[i];
      Ulke ulke = Ulke.maptenOlustur(ulkeMap);
      _butunUlkeler.add(ulke);
    }
    setState(() {});
  }

  void _ulkeTiklandi(BuildContext context, Ulke ulke) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(builder: (context) {
      return UlkeDetaySayfasi(ulke);
    });
    Navigator.push(context, sayfaYolu);
  }

  Future<void> _favorileriCihazHafizasindanCek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? favoriler = prefs.getStringList("favorite");

    if (favoriler != null) {
      for (String cca2 in favoriler) {
        _favoriUlkelerKodlari.add(cca2);
      }
    }
  }

  void _favorilerSayfasiniAc(BuildContext context) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (context) {
        return Favoriler(_butunUlkeler, _favoriUlkelerKodlari);
      },
    );
    Navigator.push(context, sayfaYolu);
  }
}
