import 'package:line_monitor/models/line_stat.dart';
import 'package:line_monitor/helper/dependencies_injector.dart';

abstract class LineListViewContract{
  void onLoadLineStatLoadingShow();
  void onLoadLIneStatLoadingDismiss();
  void onLoadLineStat(List<LineStat> items);
  void onLoadLineStatError();
}


class LineListPresenter{
  LineListViewContract _view;
  LineStatRepository _repository;


  LineListPresenter(this._view){
    _repository = new Injector().lineStatRepository;
  }


  void loadLineList(){
    _view.onLoadLineStatLoadingShow();
    _repository.fetchLineStatFromFirebase()
        .then((data){
          _view.onLoadLIneStatLoadingDismiss();
          _view.onLoadLineStat(data);
        })
        .catchError((onError)=>_view.onLoadLineStatError());
  }
}


