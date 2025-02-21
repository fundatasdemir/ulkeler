import 'package:dunyaulkeleri/ulke.dart';
import 'package:dunyaulkeleri/ulke_detay_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrtakListe extends StatefulWidget {
  List<Ulke> _ulkeler = [];

  List<String> _favoriUlkelerKodlari = [];

  OrtakListe(this._ulkeler, this._favoriUlkelerKodlari);

  @override
  State<OrtakListe> createState() => _OrtakListeState();
}

class _OrtakListeState extends State<OrtakListe> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._ulkeler.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Ulke ulke = widget._ulkeler[index];

    return Card(
      child: ListTile(
        title: Text(ulke.name),
        subtitle: Text("Başkent: ${ulke.capital}"),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(ulke.flag),
        ),
        trailing: IconButton(
          onPressed: () {
            _favoriTiklandi(ulke);
          },
          icon: Icon(
            widget._favoriUlkelerKodlari.contains(ulke.cca2)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
        onTap: () {
          _ulkeTiklandi(context, ulke);
        },
      ),
    );
  }

  void _ulkeTiklandi(BuildContext context, Ulke ulke) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (context) {
        return UlkeDetaySayfasi(ulke as Ulke);
      },
    );
    Navigator.push(context, sayfaYolu);
  }

  void _favoriTiklandi(Ulke ulke) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget._favoriUlkelerKodlari.contains(ulke.cca2)) {
      widget._favoriUlkelerKodlari.remove(ulke.cca2);
    } else {
      widget._favoriUlkelerKodlari.add(ulke.cca2);
    }

    await prefs.setStringList("favorite", widget._favoriUlkelerKodlari);

    setState(() {});
  }
}
