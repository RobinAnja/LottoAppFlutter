import 'package:flutter/material.dart';
import 'package:flutter_lotto_app/data/blocs/lotto_bloc.dart';
import 'package:flutter_lotto_app/data/model/lotto_ticket.dart';

class LottoCardWidget extends StatelessWidget {
  LottoCardWidget({this.pageIndex});
  int pageIndex;

  @override
  Widget build(BuildContext context) {
    LottoBloc lottoBloc = LottoBloc();
    LottoTicket lottoTicket = LottoTicket();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        clipBehavior: Clip.none,
        color: Colors.white,
        margin: const EdgeInsets.all(20.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: StreamBuilder(
            stream: lottoBloc.lottoTicketStream,
            initialData: lottoBloc.lottoTicket,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                lottoTicket = snapshot.data;
              }
              return Container(
                height: 400,
                //padding: const EdgeInsets.all(8.0),
                margin:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: GridView.count(
                        physics: new NeverScrollableScrollPhysics(),
                        crossAxisCount: 7,
                        children: List.generate(
                          49,
                          (index) {
                            index += 1;
                            return GestureDetector(
                              onTap: () {
                                lottoBloc.singleLottoNumberSink
                                    .add({pageIndex: index});
                              },
                              child: GridTile(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 0.5),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Text("$index"),
                                      ),
                                      lottoTicket
                                              .getTipFields()
                                              .tipFields[pageIndex]
                                              .lottoNumbers
                                              .contains(index)
                                          ? Stack(
                                              children: <Widget>[
                                                Center(
                                                    child:
                                                        Image.asset("x.png")),
                                                Center(
                                                  child: Text(
                                                    "$index",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: IconButton(
                                    icon: Image.asset("garbage.png"),
                                    onPressed: () {
                                      lottoBloc.removeLottoNumbersSink
                                          .add(pageIndex);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: IconButton(
                                    icon: Image.asset("dices.png"),
                                    onPressed: () {
                                      lottoBloc.generateLottoNumbersSink.add(1);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: GestureDetector(
                                    child: Text("+1"),
                                    onTap: () {
                                      lottoBloc.generateLottoNumbersSink.add(1);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: GestureDetector(
                                    child: Text("+4"),
                                    onTap: () {
                                      lottoBloc.generateLottoNumbersSink.add(4);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: GestureDetector(
                                    child: Text("+8"),
                                    onTap: () {
                                      lottoBloc.generateLottoNumbersSink.add(8);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: GestureDetector(
                                    child: Text("+14"),
                                    onTap: () {
                                      lottoBloc.generateLottoNumbersSink
                                          .add(14);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
