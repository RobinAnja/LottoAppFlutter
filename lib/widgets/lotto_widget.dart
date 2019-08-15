import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lotto_app/util/LottoColors.dart';
import 'package:flutter_lotto_app/widgets/additional_lotteries_widget.dart';
import 'package:flutter_lotto_app/widgets/drawing_date_widget.dart';
import 'package:flutter_lotto_app/widgets/lotto_card_widget.dart';
import 'package:flutter_lotto_app/widgets/price_overview_widget.dart';
import 'package:flutter_lotto_app/widgets/ticket_number_widget.dart';
import 'package:flutter_lotto_app/widgets/week_term_widget.dart';
import 'package:page_indicator/page_indicator.dart';

class LottoWidget extends StatefulWidget {
  const LottoWidget({Key key}) : super(key: key);

  @override
  _LottoWidgetState createState() => _LottoWidgetState();
}

class _LottoWidgetState extends State<LottoWidget> {
  StreamController<double> controller = StreamController.broadcast();

  PageController pageController;
  double page;
  int currentPage = 0;
  double position;

  List<Widget> lottoCards;

  @override
  void initState() {
    pageController = PageController();
    lottoCards = List.generate(14, (index) {
      LottoCardWidget card = LottoCardWidget(
        pageIndex: index,
      );
      return card;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              height: 470,
              child: NotificationListener<ScrollNotification>(
                child: PageIndicatorContainer(
                  pageView: PageView(
                    onPageChanged: (pos) {
                      currentPage = pos;
                    },
                    //controller: pageController,
                    children: lottoCards,
                  ),
                  align: IndicatorAlign.bottom,
                  length: lottoCards.length,
                  indicatorColor: Colors.white,
                  indicatorSelectorColor: LottoColors.red,
                  shape: IndicatorShape.roundRectangleShape(
                      size: Size(15, 5), cornerSize: const Size.square(3)),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(bottom: 200.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  TicketNumberWidget(),
                  AdditionalLotteriesWidget(),
                  DrawingDateWidget(),
                  WeekTermWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30.0),
                    child: Center(
                      child: Text(
                        "Chance ca. 1:140 Mio. Teilnahme ab 18 Jahren. Glückspiel kann süchtig machen. Hilfe BZgA.",
                        style: TextStyle(color: Colors.black38),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        PriceOverviewWidget(),
      ],
    );
  }
}
