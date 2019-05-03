import 'package:line_monitor/models/crypto_data.dart';
import 'package:line_monitor/helper/dependencies_injector.dart';

abstract class CryptoListViewContract{
  void onLoadCryptoComplete(List<Crypto> items);
  void onLoadCryptoError();
}


class CryptoListPresenter{
  CryptoListViewContract _view;
  CryptoRepository _repository;


  CryptoListPresenter(this._view){
    _repository = new Injector().cryptoRepository;
  }


  void loadCurrencies(){
    _repository.fetchCryptoCurrency()
        .then((data)=>_view.onLoadCryptoComplete(data))
        .catchError((onError)=>_view.onLoadCryptoError());
  }
}


