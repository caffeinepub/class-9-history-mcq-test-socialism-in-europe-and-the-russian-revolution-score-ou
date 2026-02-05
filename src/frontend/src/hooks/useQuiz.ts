import { useState, useEffect } from 'react';
import { useGetQuestions, useSubmitAnswers } from './useQueries';
import type { MCQ, Answer } from '../backend';

function orderQuestionsByDifficulty(questions: MCQ[]): MCQ[] {
  const difficultyOrder = { easy: 0, medium: 1, hard: 2 };
  
  return [...questions].sort((a, b) => {
    const diffA = difficultyOrder[a.difficulty];
    const diffB = difficultyOrder[b.difficulty];
    
    if (diffA !== diffB) {
      return diffA - diffB;
    }
    
    return a.question.localeCompare(b.question);
  });
}

export function useQuiz() {
  const { data: rawQuestions, isLoading } = useGetQuestions();
  const submitMutation = useSubmitAnswers();
  
  const [questions, setQuestions] = useState<MCQ[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, number>>({});
  const [score, setScore] = useState<number>(0);

  useEffect(() => {
    if (rawQuestions && rawQuestions.length > 0) {
      const orderedQuestions = orderQuestionsByDifficulty(rawQuestions);
      setQuestions(orderedQuestions);
    }
  }, [rawQuestions]);

  const selectAnswer = (questionIndex: number, optionIndex: number) => {
    setSelectedAnswers((prev) => ({
      ...prev,
      [questionIndex]: optionIndex,
    }));
  };

  const nextQuestion = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex((prev) => prev + 1);
    }
  };

  const submitQuiz = async () => {
    const answers: Answer[] = Object.entries(selectedAnswers).map(([questionIndex, selectedOption]) => ({
      questionIndex: BigInt(questionIndex),
      selectedOption: BigInt(selectedOption),
    }));

    try {
      const result = await submitMutation.mutateAsync(answers);
      setScore(Number(result));
    } catch (error) {
      console.error('Failed to submit quiz:', error);
    }
  };

  const restartQuiz = () => {
    setCurrentQuestionIndex(0);
    setSelectedAnswers({});
    setScore(0);
  };

  return {
    questions,
    currentQuestionIndex,
    selectedAnswers,
    score,
    isLoading,
    isSubmitting: submitMutation.isPending,
    selectAnswer,
    nextQuestion,
    submitQuiz,
    restartQuiz,
  };
}
