//CONTROL Mock or Production
//CRYPTO CONTROL
import 'package:line_monitor/data/mock/crypto_data_mock.dart';
import 'package:line_monitor/data/production/crypto_data_production.dart';
import 'package:line_monitor/models/crypto_data.dart';




//LINESTAT CONTROL
import 'package:line_monitor/data/production/line_list_data_production.dart';
import 'package:line_monitor/models/line_stat.dart';




enum Flavor { MOCK, PROD}

//Dependecies Injection

class Injector {

  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;


  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector(){
    return _singleton;
  }

  Injector._internal();


  CryptoRepository get cryptoRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockCryptoRepository();
      default :
        return new ProdCryptoRepository();
    }
  }



  LineStatRepository get lineStatRepository{
    switch (_flavor) {
      case Flavor.MOCK:
        return new ProdLineStatRepository();
      default :
        return new ProdLineStatRepository();
    }
  }

}
