import 'package:flutter/material.dart';
import 'package:flutter_lotto_app/data/blocs/lotto_bloc.dart';
import 'package:flutter_lotto_app/data/model/lotto_ticket.dart';
import 'package:flutter_lotto_app/util/LottoColors.dart';

class PriceOverviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LottoBloc lottoBloc = LottoBloc();
    LottoTicket lottoTicket = LottoTicket();
    double position;
    bool useDuration = true;

    return StreamBuilder(
      stream: lottoBloc.bottomSheetController.stream,
      builder: (context, snapshot) => Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    useDuration = false;
                    position = MediaQuery.of(context).size.height -
                        details.globalPosition.dy;
                    print('position dy = $position');

                    if (position >= 110 && position <= 500) {
                      if (position >= 450) {
                        position = 500;
                      }
                      lottoBloc.bottomSheetController.add(position);
                    }
                  },
                  onVerticalDragEnd: (DragEndDetails details) {
                    useDuration = true;
                    if (details.velocity.pixelsPerSecond.dy > 0) {
                      position = 110;
                    } else {
                      position = 500;
                    }
                    lottoBloc.bottomSheetController.add(position);
                  },
                  onTap: () {
                    useDuration = true;
                    position = position == 500 ? 110 : 500;
                    lottoBloc.bottomSheetController.add(position);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30.0,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(
                        position == 500
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        size: 30.0,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: useDuration ? 200 : 0),
                  color: Colors.white,
                  height: snapshot.hasData ? snapshot.data : 110.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  child: StreamBuilder(
                    initialData: lottoBloc.lottoTicket,
                    stream: lottoBloc.lottoTicketStream,
                    builder: (context, snapshot) {
                      if (snapshot != null) {
                        lottoTicket = snapshot.data;
                      }
                      return ListView(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Gesamtpreis ",
                                    style: TextStyle(
                                      color: LottoColors.text,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    lottoTicket.getPrice(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width - 40,
                              child: FlatButton(
                                  child: Text("SCHEIN ABGEBEN",
                                      style: TextStyle(color: Colors.white)),
                                  color: LottoColors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0)),
                                  onPressed: () {})),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("Anzahl der Tippfelder: "),
                                ),
                                Expanded(
                                  child: Text(
                                    lottoTicket.getFullTipFieldCount(),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("Wochentag: "),
                                ),
                                Expanded(
                                  child: Text(
                                    lottoTicket.getDrawingDateString(),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("Laufzeit: "),
                                ),
                                Expanded(
                                  child: Text(
                                    lottoTicket.getDuration().toString() +
                                        " Wochen",
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
