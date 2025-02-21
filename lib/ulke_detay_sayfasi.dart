import 'package:dunyaulkeleri/ulke.dart';
import 'package:flutter/material.dart';

class UlkeDetaySayfasi extends StatelessWidget {
  final Ulke _ulke;

  UlkeDetaySayfasi(this._ulke);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_ulke.name),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 32,
        ),
        _buildFlag(context),
        SizedBox(height: 24),
        _buildNameText(),
        SizedBox(height: 36),
        _buildTumDetaylar(),
      ],
    );
  }

  Widget _buildTumDetaylar() {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Column(children: [
        _builDetayRow("Ülke İsmi:", _ulke.name),
        _builDetayRow("Başkent:", _ulke.capital),
        _builDetayRow("Bölge:", _ulke.region),
        _builDetayRow("Nüfus:", _ulke.population.toString()),
        _builDetayRow("Dil:", _ulke.language),
      ]),
    );
  }

  Widget _buildFlag(BuildContext context) {
    return Image.network(
      _ulke.flag,
      width: MediaQuery.sizeOf(context).width / 2,
      fit: BoxFit.fitWidth, //genişliğe göre resmi ayarla,fitle
    );
  }

  Widget _buildNameText() {
    return Text(
      _ulke.name,
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _builDetayRow(String baslik, String detay) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            baslik,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            //textAlign: TextAlign.end,
          ),
        ),
        SizedBox(width: 32),
        Expanded(
          flex: 3,
          child: Text(
            detay,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}
