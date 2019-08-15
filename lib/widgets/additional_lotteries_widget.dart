import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lotto_app/data/blocs/lotto_bloc.dart';
import 'package:flutter_lotto_app/data/enums/game_type.dart';
import 'package:flutter_lotto_app/data/model/lotto_ticket.dart';
import 'package:flutter_lotto_app/util/LottoColors.dart';

class AdditionalLotteriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LottoBloc lottoBloc = LottoBloc();
    LottoTicket lottoTicket = LottoTicket();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: StreamBuilder(
        initialData: lottoBloc.lottoTicket,
        stream: lottoBloc.lottoTicketStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            lottoTicket = snapshot.data;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "ZUSATZLOTTERIEN",
                style: TextStyle(
                  color: LottoColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Spiel 77",
                      style: TextStyle(
                          color: LottoColors.spiel77,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Platform.isAndroid
                        ? Switch(
                            activeColor: Colors.red,
                            value: lottoTicket.getSpiel77Selected(),
                            onChanged: (bool) {
                              lottoBloc.additionalLotteriesSink
                                  .add({GameType.spiel77: bool});
                            },
                          )
                        : CupertinoSwitch(
                            value: lottoTicket.getSpiel77Selected(),
                            onChanged: (bool) {
                              lottoBloc.additionalLotteriesSink
                                  .add({GameType.spiel77: bool});
                            },
                          ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Super 6",
                      style: TextStyle(
                          color: LottoColors.super6,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Platform.isAndroid
                        ? Switch(
                            activeColor: Colors.red,
                            value: lottoTicket.getSuper6Selected(),
                            onChanged: (bool) {
                              lottoBloc.additionalLotteriesSink
                                  .add({GameType.super6: bool});
                            },
                          )
                        : CupertinoSwitch(
                            value: lottoTicket.getSuper6Selected(),
                            onChanged: (bool) {
                              lottoBloc.additionalLotteriesSink
                                  .add({GameType.super6: bool});
                            },
                          ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Glückspirale",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Platform.isAndroid
                        ? Switch(
                            activeColor: Colors.red,
                            value: lottoTicket.getGlueckSpiraleSelected(),
                            onChanged: (bool) {
                              lottoBloc.additionalLotteriesSink
                                  .add({GameType.gluecksspirale: bool});
                            },
                          )
                        : CupertinoSwitch(
                            value: lottoTicket.getGlueckSpiraleSelected(),
                            onChanged: (bool) {
                              lottoBloc.additionalLotteriesSink
                                  .add({GameType.gluecksspirale: bool});
                            },
                          ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Siegerchance",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Platform.isAndroid
                        ? Switch(
                            activeColor: Colors.red,
                            value: lottoTicket.getSiegerChanceSelected(),
                            onChanged: (bool) {
                              lottoBloc.additionalLotteriesSink
                                  .add({GameType.siegerchance: bool});
                            },
                          )
                        : CupertinoSwitch(
                            value: lottoTicket.getSiegerChanceSelected(),
                            onChanged: (bool) {
                              lottoBloc.additionalLotteriesSink
                                  .add({GameType.siegerchance: bool});
                            },
                          ),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
