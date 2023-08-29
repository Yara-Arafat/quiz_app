import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int questionIndex = 0;
  bool showResultMessage = false;
  int? yourchoiseIndex;
  int totalScore = 0;
  List<Map<String, dynamic>> questionsWithAnswers = [
    {
      'question': 'What is your favorite sport?',
      'answer': ['Football', 'Tennis', 'Basketball', 'Volleyball'],
      'correctAnswerIndex': 2,
      'icon': [
        "assets/images/Football.png",
        "assets/images/Tennis.png",
        "assets/images/Basketball.png",
        "assets/images/Volleyball.png",
      ],
    },
    {
      'question': 'What is your favourite color?',
      'answer': ['Blue', 'Green', 'Red', 'Yellow'],
      'correctAnswerIndex': 0,
      'icon': [
        "assets/images/Blue.png",
        "assets/images/Green.png",
        "assets/images/Red.png",
        "assets/images/Yellow.png",
      ],
    },
    {
      'question': 'What is your favourite animal?',
      'answer': ['Horse', 'Cat', 'Dog', 'Camel'],
      'correctAnswerIndex': 1,
      'icon': [
        "assets/images/Horse.png",
        "assets/images/Cat.png",
        "assets/images/Dog.png",
        "assets/images/Camel.png",
      ],
    },
    {
      'question': 'What is your favourite fruit?',
      'answer': ['Mango', 'Strawberry', 'Cherry', 'Apple'],
      'correctAnswerIndex': 3,
      'icon': [
        "assets/images/Mango.png",
        "assets/images/Strawberry.png",
        "assets/images/Cherry.png",
        "assets/images/apple.png",
      ],
    },
  ];

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      showResultMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionWithAnswer = questionsWithAnswers[questionIndex];
    final size = MediaQuery.of(context).size;
    int currentStep = questionIndex + 1;
    int numOfSteps = questionsWithAnswers.length;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: showResultMessage == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showResultMessage == false) ...[
                      SizedBox(height: size.height * 0.1),
                      Text(
                        questionWithAnswer['question'],
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Answer and get points',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'step $currentStep of $numOfSteps ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: StepProgressIndicator(
                                  totalSteps: numOfSteps,
                                  currentStep: questionIndex + 1,
                                  selectedColor: Colors.green,
                                  fallbackLength: 350,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.05),
                      for (int i = 0;
                          i < questionWithAnswer['answer'].length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                yourchoiseIndex = i;
                                if (yourchoiseIndex ==
                                    questionWithAnswer['correctAnswerIndex']
                                        as int) {
                                  totalScore++;
                                }
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: i == yourchoiseIndex
                                      ? Colors.green
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      child: ImageIcon(
                                        AssetImage(
                                            questionWithAnswer['icon'][i]),
                                        
                                        size: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      questionWithAnswer['answer'][i],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: i == yourchoiseIndex
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (yourchoiseIndex != null) {
                                if (questionIndex <
                                    questionsWithAnswers.length - 1) {
                                  questionIndex++;
                                } else {
                                  showResultMessage = true;
                                }
                                yourchoiseIndex = null;
                              } else {
                                final sBar = SnackBar(
                                  action: SnackBarAction(
                                    textColor: Colors.black,
                                    label: 'Ok',
                                    onPressed: () {},
                                  ),
                                  content: Text(' Please choose an answer!'),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red.shade800,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  behavior: SnackBarBehavior.floating,
                                  padding: EdgeInsets.all(4.0),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(sBar);
                              }
                            });
                          },
                          child: Text('Next'),
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 10,
                      ),
                    ]
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'your score is: $totalScore/${questionsWithAnswers.length}',
                        style: TextStyle(fontSize: 30),
                      ),
                      TextButton(
                        onPressed: resetQuiz,
                        child: Text('Reset Quiz'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green,
                          textStyle: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
