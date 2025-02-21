import 'package:dunyaulkeleri/ortak_liste.dart';
import 'package:dunyaulkeleri/ulke.dart';
import 'package:flutter/material.dart';

class Favoriler extends StatefulWidget {
  final List<Ulke> _butunUlkeler;

  final List<String> _favoriUlkelerKodlari;

  Favoriler(this._butunUlkeler, this._favoriUlkelerKodlari);

  @override
  State<Favoriler> createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  List<Ulke> _favoriUlkeler = [];

  @override
  void initState() {
    super.initState();
    for (Ulke ulke in widget._butunUlkeler) {
      if (widget._favoriUlkelerKodlari.contains(ulke.cca2)) {
        _favoriUlkeler.add(ulke);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Favoriler"),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return OrtakListe(_favoriUlkeler, widget._favoriUlkelerKodlari);
  }
}
