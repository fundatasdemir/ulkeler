class Ulke {
  String cca2;
  String name;
  String capital;
  String region;
  int population;
  String flag;
  String language;

  Ulke.maptenOlustur(Map<String, dynamic> ulkeMap)
      : cca2 = ulkeMap["cca2"] ?? "",
        name = ulkeMap["name"]?["common"] ?? "",
        capital = (ulkeMap["capital"] as List<dynamic>).isNotEmpty
            ? ulkeMap["capital"][0]
            : "",
        region = ulkeMap["region"] ?? "",
        population = ulkeMap["population"],
        flag = ulkeMap["flags"]?["png"] ?? "",
        language = (ulkeMap["languages"] as Map<String, dynamic>).isNotEmpty
            ? (ulkeMap["languages"] as Map<String, dynamic>)
                .entries
                .toList()[0]
                .value
            : "";
}


/*  [
  { 
    "flags": {
      "png": "https://flagcdn.com/w320/tr.png",
      "svg": "https://flagcdn.com/tr.svg",
      "alt": "The flag of Turkey has a red field bearing a large fly-side facing white crescent and a smaller five-pointed white star placed just outside the crescent opening. The white crescent and star are offset slightly towards the hoist side of center."
    },
    "name": {
      "common": "Turkey",
      "official": "Republic of Turkey",
      "nativeName": {
        "tur": {
          "official": "Türkiye Cumhuriyeti",
          "common": "Türkiye"
        }
      }
    },
    "cca2": "TR",
    "capital": [
      "Ankara"
    ],
    "region": "Asia",
    "languages": {
      "tur": "Turkish"
    },
    "population": 84339067
  }
]
*/