import 'dart:math';

import 'package:flutter_lotto_app/data/enums/drawing_date.dart';
import 'package:flutter_lotto_app/data/enums/game_type.dart';

class LottoTicket {
  static final LottoTicket _instance = LottoTicket._internal();
  factory LottoTicket() => _instance;

  double _servicePrice = 0.2;
  double _price = 0.0;
  LottoTipFields _tipFields = LottoTipFields();
  List<int> ticketNumber = List<int>.generate(8, (i) => i + 1);
  int _fullTipFieldsCount = 0;
  bool _spiel77Selected = false;
  bool _super6Selected = false;
  bool _glueckSpiraleSelected = false;
  bool _siegerChanceSelected = false;
  DrawingDate _weekDay = DrawingDate.MittwochUndSamstag;
  int _duration = 1;

  LottoTicket._internal() {}

  updatePrice() {
    var tmpPrice = 0.0;
    _fullTipFieldsCount = 0;

    _tipFields.tipFields.forEach((tipField) {
      if (tipField.isFull) {
        _fullTipFieldsCount++;
      }
    });

    if (_fullTipFieldsCount > 0) {
      tmpPrice = _fullTipFieldsCount.toDouble();
      tmpPrice = tmpPrice * _duration;
      tmpPrice =
          tmpPrice * (_weekDay == DrawingDate.MittwochUndSamstag ? 2 : 1);

      if (_spiel77Selected) {
        tmpPrice += 5.0;
      }
      if (_super6Selected) {
        tmpPrice += 2.5;
      }
      if (_glueckSpiraleSelected) {
        tmpPrice += 5.0;
      }
      if (_siegerChanceSelected) {
        tmpPrice += 3.0;
      }

      tmpPrice += _servicePrice;
    }
    _price = tmpPrice;
  }

  actionOnLottoNumber(int number, int index) {
    if (_tipFields.tipFields[index].lottoNumbers.contains(number)) {
      _tipFields.tipFields[index].lottoNumbers.remove(number);
    } else {
      if (_tipFields.tipFields[index].lottoNumbers.length < 6) {
        _tipFields.tipFields[index].lottoNumbers.add(number);
      }
    }
    _tipFields.tipFields[index].isFull =
        _tipFields.tipFields[index].lottoNumbers.length == 6;
    updatePrice();
  }

  removeLottoNumbers(int tipFieldIndex) {
    _tipFields.tipFields[tipFieldIndex].lottoNumbers.clear();
    _tipFields.tipFields[tipFieldIndex].isFull = false;
    updatePrice();
  }

  generateRandomLottoNumbers(int cardCount) {
    var rnd = new Random();
    List<int> tmpNumbers;

    for (var y = 0; y < cardCount; y++) {
      tmpNumbers = List.generate(49, (number) {
        return number += 1;
      });

      _tipFields.tipFields[y].lottoNumbers.clear();

      for (var i = 0; i < 6; i++) {
        int nbr = rnd.nextInt(tmpNumbers.length);
        _tipFields.tipFields[y].lottoNumbers.add(tmpNumbers.elementAt(nbr));
        tmpNumbers.remove(tmpNumbers.elementAt(nbr));
      }
      _tipFields.tipFields[y].isFull = true;
    }
    updatePrice();
  }

  generateTicketNumber() {
    var rnd = Random();

    for (var i = 0; i < ticketNumber.length; i++) {
      ticketNumber[i] = rnd.nextInt(8) + 1;
    }
  }

  changeSingleTicketNumber(int index, bool increase) {
    int number = ticketNumber[index];
    number = increase ? number + 1 : number - 1;
    if (number < 1) {
      number = 9;
    } else if (number > 9) {
      number = 1;
    }
    ticketNumber[index] = number;
  }

  LottoTipFields getTipFields() {
    return _tipFields;
  }

  setAdditionalLotteries(GameType game, bool selected) {
    switch (game) {
      case GameType.spiel77:
        _spiel77Selected = selected;
        break;
      case GameType.super6:
        _super6Selected = selected;
        break;
      case GameType.gluecksspirale:
        _glueckSpiraleSelected = selected;
        if (!selected && _siegerChanceSelected) {
          _siegerChanceSelected = false;
        }
        break;
      case GameType.siegerchance:
        _siegerChanceSelected = selected;
        if (selected && !_glueckSpiraleSelected) {
          _glueckSpiraleSelected = true;
        }
        break;
    }
  }

  setWeekDay(DrawingDate day) {
    _weekDay = day;
    updatePrice();
  }

  setDuration(int duration) {
    _duration = duration;
    updatePrice();
  }

  String getPrice() {
    String tmpPrice = _price.toString().replaceAll(".", ",");
    tmpPrice += "0 €";
    return tmpPrice;
  }

  bool getSpiel77Selected() {
    return _spiel77Selected;
  }

  bool getSuper6Selected() {
    return _super6Selected;
  }

  bool getGlueckSpiraleSelected() {
    return _glueckSpiraleSelected;
  }

  bool getSiegerChanceSelected() {
    return _siegerChanceSelected;
  }

  DrawingDate getDrawingDate() {
    return _weekDay;
  }

  String getDrawingDateString() {
    String tmpWeekDay = "Mi. und Sa.";
    if (_weekDay == DrawingDate.Mittwoch) {
      tmpWeekDay = "Mittwoch";
    } else if (_weekDay == DrawingDate.Samstag) {
      tmpWeekDay = "Samstag";
    }
    return tmpWeekDay;
  }

  int getDuration() {
    return _duration;
  }

  String getFullTipFieldCount() {
    return _fullTipFieldsCount.toString();
  }
}

class LottoTipFields {
  List<LottoTipField> tipFields = List<LottoTipField>();

  LottoTipFields() {
    tipFields = List.generate(14, (index) {
      return LottoTipField(index);
    });
  }
}

class LottoTipField {
  int index;
  bool isFull = false;
  List<int> lottoNumbers = List<int>();

  LottoTipField(int index) {
    this.index = index;
  }
}
