import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter & Dart Quiz',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // whole page orange
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.question_mark_rounded,
                  size: 120, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                "Flutter & Dart",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Quiz Challenge",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  "10 Questions • Multiple Topics",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const QuizPage()));
                },
                child: Container(
                  width: 180,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Start Quiz",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;
  int secondsLeft = 15;
  Color timerColor = Colors.red;
  Timer? timer;

  final List<Map<String, Object>> questions = [
    {
      'question': 'What is a StatefulWidget in Flutter?',
      'answers': [
        {'text': 'A widget that cannot change', 'correct': false},
        {'text': 'A widget that can change state over time', 'correct': true},
        {'text': 'A widget used only for animations', 'correct': false},
        {'text': 'A widget that is immutable', 'correct': false},
      ],
    },
    {
      'question': 'What language is used to build Flutter apps?',
      'answers': [
        {'text': 'Kotlin', 'correct': false},
        {'text': 'Dart', 'correct': true},
        {'text': 'Java', 'correct': false},
        {'text': 'Swift', 'correct': false},
      ],
    },
    {
      'question': 'Which widget is immutable in Flutter?',
      'answers': [
        {'text': 'StatefulWidget', 'correct': false},
        {'text': 'StatelessWidget', 'correct': true},
        {'text': 'Container', 'correct': false},
        {'text': 'Column', 'correct': false},
      ],
    },
    {
      'question': 'Which function starts the Flutter app?',
      'answers': [
        {'text': 'runApp()', 'correct': true},
        {'text': 'startApp()', 'correct': false},
        {'text': 'mainApp()', 'correct': false},
        {'text': 'initApp()', 'correct': false},
      ],
    },
    {
      'question': 'What does “hot reload” do?',
      'answers': [
        {'text': 'Restarts the app completely', 'correct': false},
        {'text': 'Reloads code changes instantly', 'correct': true},
        {'text': 'Clears app cache', 'correct': false},
        {'text': 'Compiles Dart to native code', 'correct': false},
      ],
    },
    {
      'question': 'Which widget is used to create layouts in a row?',
      'answers': [
        {'text': 'Column', 'correct': false},
        {'text': 'Row', 'correct': true},
        {'text': 'Stack', 'correct': false},
        {'text': 'ListView', 'correct': false},
      ],
    },
    {
      'question': 'What is used to handle asynchronous tasks in Dart?',
      'answers': [
        {'text': 'Future', 'correct': true},
        {'text': 'Loop', 'correct': false},
        {'text': 'Array', 'correct': false},
        {'text': 'Thread', 'correct': false},
      ],
    },
    {
      'question': 'What does “setState()” do?',
      'answers': [
        {'text': 'Deletes a widget', 'correct': false},
        {'text': 'Updates the UI when state changes', 'correct': true},
        {'text': 'Stops the app', 'correct': false},
        {'text': 'Refreshes the timer', 'correct': false},
      ],
    },
    {
      'question': 'Which widget allows scrolling in Flutter?',
      'answers': [
        {'text': 'Expanded', 'correct': false},
        {'text': 'ListView', 'correct': true},
        {'text': 'SizedBox', 'correct': false},
        {'text': 'AppBar', 'correct': false},
      ],
    },
    {
      'question': 'What file defines app dependencies in Flutter?',
      'answers': [
        {'text': 'pubspec.yaml', 'correct': true},
        {'text': 'config.json', 'correct': false},
        {'text': 'manifest.xml', 'correct': false},
        {'text': 'package.json', 'correct': false},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    secondsLeft = 15;
    timerColor = Colors.red;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
          timerColor =
              secondsLeft % 2 == 0 ? Colors.red : Colors.blue; // change color
        });
      } else {
        nextQuestion();
      }
    });
  }

  void answerQuestion(bool correct) {
    if (correct) score++;
    nextQuestion();
  }

  void nextQuestion() {
    timer?.cancel();
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
      startTimer();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ResultPage(score: score, total: questions.length)));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentQuestion];
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Q${currentQuestion + 1}/${questions.length}"),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: timerColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "$secondsLeft s",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Text("Score: $score"),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              q['question'] as String,
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...(q['answers'] as List<Map<String, Object>>).map((a) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => answerQuestion(a['correct'] as bool),
                  child: Text(a['text'] as String,
                      style: const TextStyle(color: Colors.black)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int total;

  const ResultPage({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, color: Colors.amber, size: 100),
              const SizedBox(height: 20),
              const Text("Quiz Completed!",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Your Score",
                  style: TextStyle(color: Colors.white.withOpacity(0.8))),
              const SizedBox(height: 10),
              Text(
                "$score / $total\n${(score / total * 100).toStringAsFixed(0)}%",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 28,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomePage()),
                        (route) => false),
                    icon: const Icon(Icons.home, color: Colors.black),
                    label: const Text('Home',
                        style: TextStyle(color: Colors.black)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizPage())),
                    icon: const Icon(Icons.refresh, color: Colors.black),
                    label: const Text('Retake',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
