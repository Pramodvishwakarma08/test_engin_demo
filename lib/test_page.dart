import 'dart:async';
import 'dart:convert';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/paper_model.dart';

class TestPage extends StatefulWidget {
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {



   var _value;


  late CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin: Duration(seconds: 600),
      end: Duration(),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds);

  int currentQuestion = 1;
  var answerList = [];
  var ansMap = {};

  nextQution() {
    currentQuestion++;
  }

  backQution() {
    currentQuestion--;
  }

  Future<PaperModel> loadAsset() async {
    var loadJson = await rootBundle.loadString("assets/DB/papers/bialogy.json");
    var jsondecode = await jsonDecode(loadJson);
    PaperModel paperModel = PaperModel.fromJson(jsondecode);
    return paperModel;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAsset();

    setState(() {
      _controller.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              color: Color(0xffeef3f9),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Attemted"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Not Answered"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                    child: Row(
                      children: [
                        Container(
                          child: Center(
                            child: Text(
                              "96",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Not Attemted"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.yellowAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Solve Later"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(child: Text("${index + 1}")),
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        nextQution();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff35cb64),
                      onPrimary: Colors.white,
                    ),
                    child: Text("Sumbit Test")),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Color(0xffeef3f9),
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Time",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                CustomTimer(
                    controller: _controller,
                    builder: (state, time) {
                      // Build the widget you want!🎉
                      return Text(
                        "${time.hours}:${time.minutes}:${time.seconds}",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      );
                    }),
              ],
            ),
            ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color(0xff35cb64),
                  onPrimary: Colors.white,
                ),
                child: Text(
                  "PAUSE",
                  style: TextStyle(fontSize: 12),
                )),
            ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color(0xff35cb64),
                  onPrimary: Colors.white,
                ),
                child: Text("Sumbit")),
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: loadAsset(),
          builder: (context, AsyncSnapshot<PaperModel?> snapshot) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            } else {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                color: Color(0xfff2f2f2),
                              ),
                              padding: EdgeInsets.all(18),
                              width: double.infinity,
                              child: Text(
                                "Q. ${currentQuestion + 1} /${snapshot.data!.questions.length}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "${snapshot.data!.questions[currentQuestion].question}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!
                                    .questions[currentQuestion].answers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: snapshot.data!.questions[currentQuestion].question[index],
                                          groupValue: currentQuestion,
                                          onChanged: (value) {
                                            setState(() {
                                              _value=value!;
                                                 print(currentQuestion+1);
                                                // print(index);
                                            });
                                          },

                                        ),
                                        Text("${snapshot.data!.questions[currentQuestion].answers[index].answer}"),
                                      ],
                                    )
                                    // child: ElevatedButton(
                                    //   style: ElevatedButton.styleFrom(
                                    //     elevation: 1,
                                    //     backgroundColor: Colors.white,
                                    //     onPrimary: Colors.black,
                                    //   ),
                                    //   onPressed: () {
                                    //     print(index);
                                    //     var ram = snapshot
                                    //         .data!
                                    //         .questions[currentQuestion]
                                    //         .answers[index]
                                    //         .identifier;
                                    //     print(ram);
                                    //     var qutionNo = snapshot.data!
                                    //         .questions[currentQuestion].id;
                                    //     answerList.add(qutionNo);
                                    //     print(qutionNo);
                                    //     // print("2222222222222222222222222222222222222222222");
                                    //     print(snapshot.data!.questions[currentQuestion].answers[index].answer);
                                    //     // print("2222222222222222222222222222222222222222222");
                                    //
                                    //   },
                                    //   child: Text(
                                    //       "${snapshot.data!.questions[currentQuestion].answers[index].answer}"),
                                    // ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if(currentQuestion>0){
                                    backQution();
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  onPrimary: Color(0xff35cb64),
                                  side: BorderSide(
                                      color: Color(0xff35cb64), width: 1)),
                              child: Text("Pervious")),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  onPrimary: Color(0xff35cb64),
                                  side: BorderSide(
                                      color: Color(0xff35cb64), width: 1)),
                              child: Text("Clear")),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if(currentQuestion+1<snapshot.data!.questions.length) {
                                    nextQution();
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff35cb64),
                                onPrimary: Colors.white,
                              ),
                              child: Text("Save & Next")),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
