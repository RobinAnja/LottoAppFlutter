import 'package:flutter/material.dart';
import 'package:flutter_lotto_app/data/blocs/lotto_bloc.dart';
import 'package:flutter_lotto_app/data/enums/drawing_date.dart';
import 'package:flutter_lotto_app/data/model/lotto_ticket.dart';
import 'package:flutter_lotto_app/util/LottoColors.dart';

class DrawingDateWidget extends StatelessWidget {
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
              Text(
                "ZIEHUNGSTAG",
                style: TextStyle(
                  color: LottoColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 10.0, bottom: 10.0),
                      child: FlatButton(
                        color: lottoTicket.getDrawingDate() ==
                                DrawingDate.MittwochUndSamstag
                            ? LottoColors.red
                            : Colors.white,
                        textColor: lottoTicket.getDrawingDate() ==
                                DrawingDate.MittwochUndSamstag
                            ? Colors.white
                            : LottoColors.red,
                        onPressed: () {
                          lottoBloc.drawingDateSink
                              .add(DrawingDate.MittwochUndSamstag);
                        },
                        child: Text("Mi. und Sa."),
                        shape: new RoundedRectangleBorder(
                            side: BorderSide(color: LottoColors.red),
                            borderRadius: new BorderRadius.circular(10.0)),
                        focusColor: LottoColors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 10.0, bottom: 10.0),
                      child: FlatButton(
                        color:
                            lottoTicket.getDrawingDate() == DrawingDate.Mittwoch
                                ? LottoColors.red
                                : Colors.white,
                        textColor:
                            lottoTicket.getDrawingDate() == DrawingDate.Mittwoch
                                ? Colors.white
                                : LottoColors.red,
                        onPressed: () {
                          lottoBloc.drawingDateSink.add(DrawingDate.Mittwoch);
                        },
                        child: Text("Mittwoch"),
                        shape: new RoundedRectangleBorder(
                            side: BorderSide(color: LottoColors.red),
                            borderRadius: new BorderRadius.circular(10.0)),
                        focusColor: LottoColors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: lottoTicket.getDrawingDate() == DrawingDate.Samstag
                          ? LottoColors.red
                          : Colors.white,
                      textColor:
                          lottoTicket.getDrawingDate() == DrawingDate.Samstag
                              ? Colors.white
                              : LottoColors.red,
                      onPressed: () {
                        lottoBloc.drawingDateSink.add(DrawingDate.Samstag);
                      },
                      child: Text("Samstag"),
                      shape: new RoundedRectangleBorder(
                          side: BorderSide(color: LottoColors.red),
                          borderRadius: new BorderRadius.circular(10.0)),
                      focusColor: LottoColors.red,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
