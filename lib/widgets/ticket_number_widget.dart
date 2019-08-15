import 'package:flutter/material.dart';
import 'package:flutter_lotto_app/data/blocs/lotto_bloc.dart';
import 'package:flutter_lotto_app/data/model/lotto_ticket.dart';
import 'package:flutter_lotto_app/util/LottoColors.dart';

class TicketNumberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LottoBloc lottoBloc = LottoBloc();
    LottoTicket lottoTicket = LottoTicket();

    return StreamBuilder(
      initialData: lottoBloc.lottoTicket,
      stream: lottoBloc.lottoTicketStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          lottoTicket = snapshot.data;
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "LOSNUMMER",
                      style: TextStyle(
                        color: LottoColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      alignment: Alignment.topRight,
                      icon: Image.asset("dices.png"),
                      onPressed: () {
                        lottoBloc.generateTicketNumberSink.add(null);
                      },
                    ),
                  )
                ],
              ),
              Container(
                  child: Row(
                      children: List.generate(7, (index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 120,
                    width: 40,
                    decoration: BoxDecoration(
                      border: new Border.all(
                          color: index < 6 ? Colors.black26 : LottoColors.red),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Image.asset(
                              "plus.png",
                              color:
                                  index < 6 ? Colors.black26 : LottoColors.red,
                            ),
                            onPressed: () {
                              lottoBloc.signleTicketNumberSink
                                  .add({index: true});
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            constraints: BoxConstraints.expand(width: 40),
                            color: index < 6 ? Colors.black26 : LottoColors.red,
                            child: Center(
                              child: Text(
                                lottoTicket.ticketNumber[index].toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Image.asset(
                              "minus.png",
                              color:
                                  index < 6 ? Colors.black26 : LottoColors.red,
                            ),
                            onPressed: () {
                              lottoBloc.signleTicketNumberSink
                                  .add({index: false});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()))
            ],
          ),
        );
      },
    );
  }
}
