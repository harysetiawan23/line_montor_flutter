import 'package:line_monitor/models/crypto_data.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProdCryptoRepository implements CryptoRepository {
  String _cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";


  @override
  Future<List<Crypto>> fetchCryptoCurrency() async {
    http.Response response = await http.get(_cryptoUrl);
    final List responseList =  jsonDecode(response.body);

    final statusCode = response.statusCode;
    if(statusCode!=200 || response.body == null){
      throw new FetchDataException("an Error Occured [Status : $statusCode]");
    }

    return responseList.map((data) => new Crypto.fromMap(data)).toList();
  }
}
