import 'package:flutter/material.dart';
import 'package:flutter_lotto_app/data/blocs/lotto_bloc.dart';
import 'package:flutter_lotto_app/data/model/lotto_ticket.dart';
import 'package:flutter_lotto_app/util/LottoColors.dart';

class WeekTermWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LottoBloc lottoBloc = LottoBloc();
    LottoTicket lottoTicket = LottoTicket();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "WOCHENLAUFZEIT",
                  style: TextStyle(
                    color: LottoColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  6,
                  (index) {
                    int duration = index == 5 ? 8 : index + 1;

                    return Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: FlatButton(
                          color: lottoTicket.getDuration() == duration
                              ? LottoColors.red
                              : Colors.white,
                          textColor: lottoTicket.getDuration() == duration
                              ? Colors.white
                              : LottoColors.red,
                          onPressed: () {
                            lottoBloc.durationSink.add(duration);
                          },
                          child: Text(duration.toString()),
                          shape: new RoundedRectangleBorder(
                              side: BorderSide(color: LottoColors.red),
                              borderRadius: new BorderRadius.circular(10.0)),
                          focusColor: LottoColors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
