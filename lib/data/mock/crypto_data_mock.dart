import 'package:line_monitor/models/crypto_data.dart';
import 'dart:async';

class MockCryptoRepository implements CryptoRepository{
  @override
  Future<List<Crypto>> fetchCryptoCurrency() {
    return new Future.value(currencies);
  }

}

var currencies  = <Crypto>[
  new Crypto(name: 'Bitcoin',price_usd: "8300.18",percent_change_1h: "-0.2"),
  new Crypto(name: 'Etherium',price_usd: "630.21",percent_change_1h: "0.23"),
  new Crypto(name: 'Ripple',price_usd: "210.65",percent_change_1h: "-0.2"),
];