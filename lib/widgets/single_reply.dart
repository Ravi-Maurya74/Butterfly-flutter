import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:intl/intl.dart';

class SingleReply extends StatefulWidget {
  SingleReply({super.key, required this.reply});

  final dynamic reply;

  @override
  State<SingleReply> createState() => _SingleReplyState();
}

class _SingleReplyState extends State<SingleReply> {
  bool hasreplierdata = false;
  late dynamic replierdata;

  Future<void> doAsyncStuff() async {
    setState(() {
      hasreplierdata = false;
    });
    replierdata =
        await NetworkHelper(url: 'api/detail/${widget.reply['user_id']}')
            .getData();
    setState(() {
      hasreplierdata = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doAsyncStuff();
  }

  @override
  Widget build(BuildContext context) {
    return !hasreplierdata
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.teal,
              ))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${replierdata['first_name']} ${replierdata['last_name']}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Kalam',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                replierdata['user_email'],
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                    fontFamily: 'Kalam'),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.reply['content'],
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontFamily: 'Kalam'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${DateFormat.yMMMMd('en_US').format(DateFormat("yyyy-MM-dd").parse((widget.reply['created'] as String).substring(0, 10)))}',
                            style: TextStyle(fontFamily: 'Kalam'),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          );
    ;
  }
}
