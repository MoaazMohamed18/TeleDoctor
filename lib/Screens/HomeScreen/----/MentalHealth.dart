import 'package:flutter/material.dart';

class Question {
  final String text;
  final List<String> answers;
  final List<int> scores;

  Question(this.text, this.answers, this.scores);
}

class MentalHealth extends StatefulWidget {
  @override
  _MentalHealthState createState() => _MentalHealthState();
}

class _MentalHealthState extends State<MentalHealth> {
  final List<Question> questions = [
    Question("1) Current mental health concerns or symptoms:",
        ["Anxiety", "Depression", "Mood swings", "Stress", "Other"], [3, 3, 2, 2, 1]),
    Question("2) Changes in mood, sleep patterns, or appetite recently:",
        ["Yes, mood changes", "Yes, sleep pattern changes", "Yes, appetite changes", "No changes"], [3, 3, 3, 0]),
    Question("3) Currently taking any medications or receiving other forms of treatment:",
        ["Yes, medications", "Yes, therapy/counseling", "Yes, other treatments", "No"], [1, 1, 1, 0]),
    Question("4) Daily functioning affected by mental health symptoms:",
        ["Not at all", "A little", "Moderately", "Severely"], [0, 1, 2, 3]),
    Question("5) Able to perform routine tasks:",
        ["Yes, without difficulty", "Yes, but with some difficulty", "No, with significant difficulty", "No, not at all"], [0, 1, 2, 3]),
    Question("6) Thoughts of self-harm or suicide recently:",
        ["Yes", "No"], [3, 0]),
    Question("7) Feel safe at home:",
        ["Yes", "No"], [0, 3]),
    Question("8) Experiencing any side effects from medications:",
        ["Yes", "No"], [2, 0]),
    Question("9) Missed any doses or made any changes to prescribed medications:",
        ["Yes", "No"], [2, 0]),
    Question("10) Primary sources of support:",
        ["Family", "Friends", "Other", "None"], [0, 0, 0, 3]),
    Question("11) Significant stressors or conflicts in personal life:",
        ["Yes", "No"], [3, 0]),
    Question("12) How do you cope with stress or difficult emotions?",
        ["Exercise", "Talking to someone", "Meditation", "Other", "None"], [0, 0, 0, 1, 2]),
    Question("13) Any coping techniques that have been particularly helpful for you:",
        ["Yes", "No"], [0, 2]),
    Question("14) Mood Rating Scale:",
        ["0-3 (Very sad)", "4-6 (Neutral)", "7-9 (Happy)", "10 (Very happy)"], [3, 2, 1, 0]),
    Question("15) How often do you feel overwhelmed or stressed?",
        ["Never", "Occasionally", "Often", "Always"], [0, 1, 2, 3]),
    Question("16) Do you have trouble sleeping or staying asleep?",
        ["Never", "Occasionally", "Often", "Always"], [0, 1, 2, 3]),
    Question("17) Have you experienced any changes in appetite or weight recently?",
        ["No changes", "Increased appetite/weight gain", "Decreased appetite/weight loss"], [0, 2, 2]),
    Question("18) Do you often feel sad, hopeless, or empty?",
        ["Never", "Occasionally", "Often", "Always"], [0, 1, 2, 3]),
    Question("19) Have you lost interest in activities you once enjoyed?",
        ["Yes", "No"], [3, 0]),
    Question("20) Do you have trouble concentrating or making decisions?",
        ["Never", "Occasionally", "Often", "Always"], [0, 1, 2, 3]),
    Question("21) How would you describe your energy levels throughout the day?",
        ["Low", "Moderate", "High"], [3, 1, 0]),
    Question("22) Have you experienced any physical symptoms such as headaches or stomach aches related to your mental health?",
        ["Yes", "No"], [2, 0]),
  ];

  final Map<int, List<bool>> answers = {};
  int totalScore = 0;

  void _calculateScore() {
    setState(() {
      totalScore = 0;
      answers.forEach((index, selectedAnswers) {
        for (int i = 0; i < selectedAnswers.length; i++) {
          if (selectedAnswers[i]) {
            totalScore += questions[index].scores[i];
          }
        }
      });
    });
  }

  String get _healthStatus {
    if (totalScore <= 20) return "Minimal mental health concerns";
    if (totalScore <= 40) return "Mild mental health concerns";
    if (totalScore <= 60) return "Moderate mental health concerns";
    if (totalScore <= 80) return "Moderately severe mental health concerns";
    return "Severe mental health concerns";
  }

  String get _advice {
    if (totalScore <= 20) {
      return "Your mental health appears to be in good condition. Keep maintaining a healthy lifestyle and continue using positive coping strategies.";
    } else if (totalScore <= 40) {
      return "You have mild mental health concerns. Consider talking to a counselor or therapist for additional support and continue practicing healthy coping mechanisms.";
    } else if (totalScore <= 60) {
      return "You have moderate mental health concerns. It's important to seek support from a mental health professional. Consider therapy, and ensure you have a good support system in place.";
    } else if (totalScore <= 80) {
      return "You have moderately severe mental health concerns. Please reach out to a mental health professional immediately. Support from family and friends is also crucial.";
    } else {
      return "You have severe mental health concerns. Seek immediate help from a mental health professional and consider reaching out to emergency services if needed. Surround yourself with supportive people.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mental Health Assessment'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ...questions.asMap().entries.map((entry) {
            int index = entry.key;
            Question question = entry.value;
            answers[index] ??= List<bool>.filled(question.answers.length, false);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question.text,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
                ...question.answers.asMap().entries.map((answerEntry) {
                  int answerIndex = answerEntry.key;
                  String answerText = answerEntry.value;
                  return CheckboxListTile(
                    title: Text(answerText,style: TextStyle(color: Colors.black)),
                    value: answers[index]![answerIndex],
                    onChanged: (value) {
                      setState(() {
                        answers[index]![answerIndex] = value!;
                      });
                    },
                  );
                }).toList(),
              ],
            );
          }).toList(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateScore,
            child: Text('Submit',style: TextStyle(color: Colors.black)),
          ),
          if (totalScore > 0) ...[
            SizedBox(height: 20),
            Text(
              'Your total score is: $totalScore',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
            Text(
              'Mental health status: $_healthStatus',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
            SizedBox(height: 10),
            Text(
              _advice,
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ]
        ],
      ),
    );
  }
}
