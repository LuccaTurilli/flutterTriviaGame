import '../models/question.dart';

List<Question> getQuestions() {
  return [
    Question(
      text: '¿Cuál es la capital de Francia?',
      options: ['Madrid', 'París', 'Londres', 'Berlín'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: '¿Cuál es el planeta más grande del sistema solar?',
      options: ['Tierra', 'Marte', 'Júpiter', 'Saturno'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: '¿Cuál es mi nombre',
      options: ['Jaime', 'Luis', 'Satiro', 'Erik'],
      correctAnswerIndex: 4,
    ),

    // Agrega más preguntas aquí
  ];
}
