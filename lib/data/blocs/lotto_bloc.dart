import 'dart:async';

import 'package:flutter_lotto_app/data/enums/drawing_date.dart';
import 'package:flutter_lotto_app/data/enums/game_type.dart';
import 'package:flutter_lotto_app/data/model/lotto_ticket.dart';

class LottoBloc {
  static final LottoBloc _instance = LottoBloc._internal();
  factory LottoBloc() => _instance;
  LottoTicket lottoTicket;

  final _generateLottoNumbersController = StreamController<int>();
  Sink<int> get generateLottoNumbersSink =>
      _generateLottoNumbersController.sink;

  final _removeLottoNumbersController = StreamController<int>();
  Sink<int> get removeLottoNumbersSink => _removeLottoNumbersController.sink;

  final _singleLottoNumberController = StreamController<Map<int, int>>();
  Sink<Map<int, int>> get singleLottoNumberSink =>
      _singleLottoNumberController.sink;

  final _generateTicketNumberController = StreamController();
  Sink get generateTicketNumberSink => _generateTicketNumberController.sink;

  final _singleTicketNumberController = StreamController<Map<int, bool>>();
  Sink<Map<int, bool>> get signleTicketNumberSink =>
      _singleTicketNumberController.sink;

  final _additionalLotteriesController =
      StreamController<Map<GameType, bool>>();
  Sink<Map<GameType, bool>> get additionalLotteriesSink =>
      _additionalLotteriesController.sink;

  final _drawingDateController = StreamController<DrawingDate>();
  Sink<DrawingDate> get drawingDateSink => _drawingDateController.sink;

  final _durationController = StreamController<int>();
  Sink<int> get durationSink => _durationController.sink;

  final _lottoTicketController = StreamController<LottoTicket>.broadcast();
  Sink<LottoTicket> get _lottoTicketSink => _lottoTicketController.sink;
  Stream<LottoTicket> get lottoTicketStream => _lottoTicketController.stream;

  StreamController<double> bottomSheetController = StreamController.broadcast();

  LottoBloc._internal() {
    lottoTicket = LottoTicket();

    _generateLottoNumbersController.stream.listen((cardIndex) {
      lottoTicket.generateRandomLottoNumbers(cardIndex);
      _lottoTicketSink.add(lottoTicket);
    });

    _removeLottoNumbersController.stream.listen((cardIndex) {
      lottoTicket.removeLottoNumbers(cardIndex);
      _lottoTicketSink.add(lottoTicket);
    });

    _singleLottoNumberController.stream
        .listen((Map<int, int> cardIndexAndNumber) {
      lottoTicket.actionOnLottoNumber(
          cardIndexAndNumber.keys.first, cardIndexAndNumber.values.first);
      _lottoTicketSink.add(lottoTicket);
    });

    _generateTicketNumberController.stream.listen((val) {
      lottoTicket.generateTicketNumber();
      _lottoTicketSink.add(lottoTicket);
    });

    _singleTicketNumberController.stream
        .listen((Map<int, bool> indexAndIncrease) {
      lottoTicket.changeSingleTicketNumber(
          indexAndIncrease.keys.first, indexAndIncrease.values.first);
      _lottoTicketSink.add(lottoTicket);
    });

    _additionalLotteriesController.stream
        .listen((Map<GameType, bool> addLottery) {
      lottoTicket.setAdditionalLotteries(
          addLottery.keys.first, addLottery.values.first);
      _lottoTicketSink.add(lottoTicket);
    });

    _drawingDateController.stream.listen((DrawingDate drawingDate) {
      lottoTicket.setWeekDay(drawingDate);
      _lottoTicketSink.add(lottoTicket);
    });

    _durationController.stream.listen((int duration) {
      lottoTicket.setDuration(duration);
      _lottoTicketSink.add(lottoTicket);
    });
  }

  @override
  void dispose() {
    _generateLottoNumbersController.close();
    _removeLottoNumbersController.close();
    _singleLottoNumberController.close();
    _additionalLotteriesController.close();
    _drawingDateController.close();
    _durationController.close();
    _lottoTicketController.close();
    generateLottoNumbersSink.close();
    removeLottoNumbersSink.close();
    singleLottoNumberSink.close();
    additionalLotteriesSink.close();
    drawingDateSink.close();
    durationSink.close();
    _lottoTicketSink.close();
  }
}
