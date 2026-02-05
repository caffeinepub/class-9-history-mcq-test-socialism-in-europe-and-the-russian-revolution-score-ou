import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Label } from '@/components/ui/label';
import { Progress } from '@/components/ui/progress';
import { BookOpen, CheckCircle2, RotateCcw } from 'lucide-react';
import { useQuiz } from './hooks/useQuiz';

type QuizScreen = 'start' | 'question' | 'result';

function App() {
  const [screen, setScreen] = useState<QuizScreen>('start');
  const {
    questions,
    currentQuestionIndex,
    selectedAnswers,
    score,
    isLoading,
    isSubmitting,
    selectAnswer,
    nextQuestion,
    submitQuiz,
    restartQuiz,
  } = useQuiz();

  const handleStart = () => {
    setScreen('question');
  };

  const handleNext = () => {
    const isLastQuestion = currentQuestionIndex === questions.length - 1;
    if (isLastQuestion) {
      submitQuiz().then(() => {
        setScreen('result');
      });
    } else {
      nextQuestion();
    }
  };

  const handleRestart = () => {
    restartQuiz();
    setScreen('start');
  };

  const currentQuestion = questions[currentQuestionIndex];
  const currentAnswer = selectedAnswers[currentQuestionIndex];
  const progress = questions.length > 0 ? ((currentQuestionIndex + 1) / questions.length) * 100 : 0;

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center p-4">
        <Card className="w-full max-w-2xl">
          <CardContent className="pt-6">
            <div className="flex flex-col items-center gap-4">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
              <p className="text-muted-foreground">Loading quiz questions...</p>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8 max-w-4xl">
        {screen === 'start' && (
          <div className="space-y-6">
            <div className="w-full overflow-hidden rounded-lg shadow-lg">
              <img
                src="/assets/generated/history-quiz-banner.dim_1600x400.png"
                alt="History Quiz Banner"
                className="w-full h-auto object-cover"
              />
            </div>

            <Card className="border-2">
              <CardHeader className="text-center space-y-4">
                <div className="flex justify-center">
                  <div className="p-4 bg-primary/10 rounded-full">
                    <BookOpen className="h-12 w-12 text-primary" />
                  </div>
                </div>
                <CardTitle className="text-3xl font-bold">
                  Class 9 History MCQ Test
                </CardTitle>
                <CardDescription className="text-lg">
                  Socialism in Europe and the Russian Revolution
                </CardDescription>
              </CardHeader>

              <CardContent className="space-y-6">
                <div className="bg-muted/50 p-6 rounded-lg space-y-4">
                  <h3 className="font-semibold text-lg">Topics Covered:</h3>
                  <ul className="space-y-2 ml-4">
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1">•</span>
                      <span>The First World War and the Russian Empire</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1">•</span>
                      <span>The February Revolution and Petrograd</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <span className="text-primary mt-1">•</span>
                      <span>After February</span>
                    </li>
                  </ul>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-center">
                  <div className="p-4 bg-card border rounded-lg">
                    <div className="text-2xl font-bold text-primary">{questions.length}</div>
                    <div className="text-sm text-muted-foreground">Questions</div>
                  </div>
                  <div className="p-4 bg-card border rounded-lg">
                    <div className="text-2xl font-bold text-primary">50</div>
                    <div className="text-sm text-muted-foreground">Total Marks</div>
                  </div>
                  <div className="p-4 bg-card border rounded-lg">
                    <div className="text-2xl font-bold text-primary">Easy → Hard</div>
                    <div className="text-sm text-muted-foreground">Difficulty</div>
                  </div>
                </div>

                <div className="bg-accent/50 p-4 rounded-lg">
                  <p className="text-sm text-center">
                    <strong>Instructions:</strong> Read each question carefully and select one answer. 
                    Questions progress from easy to hard. Your final score will be displayed at the end.
                  </p>
                </div>
              </CardContent>

              <CardFooter className="flex justify-center">
                <Button size="lg" onClick={handleStart} className="px-8">
                  Start Test
                </Button>
              </CardFooter>
            </Card>
          </div>
        )}

        {screen === 'question' && currentQuestion && (
          <div className="space-y-6">
            <div className="space-y-2">
              <div className="flex items-center justify-between">
                <span className="text-sm text-muted-foreground">
                  Question {currentQuestionIndex + 1} of {questions.length}
                </span>
                <Badge variant={
                  currentQuestion.difficulty === 'easy' ? 'secondary' :
                  currentQuestion.difficulty === 'medium' ? 'default' : 'destructive'
                }>
                  {currentQuestion.difficulty.charAt(0).toUpperCase() + currentQuestion.difficulty.slice(1)}
                </Badge>
              </div>
              <Progress value={progress} className="h-2" />
            </div>

            <Card className="border-2">
              <CardHeader>
                <CardTitle className="text-xl leading-relaxed">
                  {currentQuestion.question}
                </CardTitle>
              </CardHeader>

              <CardContent>
                <RadioGroup
                  value={currentAnswer !== undefined ? currentAnswer.toString() : undefined}
                  onValueChange={(value) => selectAnswer(currentQuestionIndex, parseInt(value))}
                >
                  <div className="space-y-3">
                    {currentQuestion.options.map((option, index) => (
                      <div
                        key={index}
                        className={`flex items-center space-x-3 p-4 rounded-lg border-2 transition-colors cursor-pointer ${
                          currentAnswer === index
                            ? 'border-primary bg-primary/5'
                            : 'border-border hover:border-primary/50 hover:bg-accent/50'
                        }`}
                        onClick={() => selectAnswer(currentQuestionIndex, index)}
                      >
                        <RadioGroupItem value={index.toString()} id={`option-${index}`} />
                        <Label
                          htmlFor={`option-${index}`}
                          className="flex-1 cursor-pointer text-base leading-relaxed"
                        >
                          {option}
                        </Label>
                      </div>
                    ))}
                  </div>
                </RadioGroup>
              </CardContent>

              <CardFooter className="flex justify-between">
                <div className="text-sm text-muted-foreground">
                  {currentAnswer !== undefined ? 'Answer selected' : 'Select an answer to continue'}
                </div>
                <Button
                  onClick={handleNext}
                  disabled={currentAnswer === undefined || isSubmitting}
                  size="lg"
                >
                  {isSubmitting ? (
                    <>
                      <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-primary-foreground mr-2"></div>
                      Submitting...
                    </>
                  ) : currentQuestionIndex === questions.length - 1 ? (
                    'Submit Test'
                  ) : (
                    'Next Question'
                  )}
                </Button>
              </CardFooter>
            </Card>
          </div>
        )}

        {screen === 'result' && (
          <div className="space-y-6">
            <Card className="border-2">
              <CardHeader className="text-center space-y-4">
                <div className="flex justify-center">
                  <div className="p-4 bg-primary/10 rounded-full">
                    <CheckCircle2 className="h-16 w-16 text-primary" />
                  </div>
                </div>
                <CardTitle className="text-3xl font-bold">Test Completed!</CardTitle>
                <CardDescription className="text-lg">
                  Here's how you performed
                </CardDescription>
              </CardHeader>

              <CardContent className="space-y-6">
                <div className="bg-primary/10 p-8 rounded-lg text-center">
                  <div className="text-6xl font-bold text-primary mb-2">
                    {score} / 50
                  </div>
                  <div className="text-lg text-muted-foreground">Your Score</div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <div className="p-4 bg-card border rounded-lg text-center">
                    <div className="text-2xl font-bold">{questions.length}</div>
                    <div className="text-sm text-muted-foreground">Questions Attempted</div>
                  </div>
                  <div className="p-4 bg-card border rounded-lg text-center">
                    <div className="text-2xl font-bold">{Math.round((score / 50) * 100)}%</div>
                    <div className="text-sm text-muted-foreground">Percentage</div>
                  </div>
                  <div className="p-4 bg-card border rounded-lg text-center">
                    <div className="text-2xl font-bold">
                      {score >= 40 ? 'Excellent' : score >= 30 ? 'Good' : score >= 20 ? 'Fair' : 'Keep Practicing'}
                    </div>
                    <div className="text-sm text-muted-foreground">Performance</div>
                  </div>
                </div>

                <div className="bg-accent/50 p-4 rounded-lg text-center">
                  <p className="text-sm">
                    {score >= 40
                      ? 'Outstanding work! You have a strong grasp of the Russian Revolution.'
                      : score >= 30
                      ? 'Well done! You understand the key concepts well.'
                      : score >= 20
                      ? 'Good effort! Review the topics to strengthen your understanding.'
                      : 'Keep studying! Focus on understanding the key events and their significance.'}
                  </p>
                </div>
              </CardContent>

              <CardFooter className="flex justify-center">
                <Button size="lg" onClick={handleRestart} className="px-8">
                  <RotateCcw className="mr-2 h-5 w-5" />
                  Retake Test
                </Button>
              </CardFooter>
            </Card>
          </div>
        )}

        <footer className="mt-12 text-center text-sm text-muted-foreground pb-4">
          <p>© 2026. Built with ❤️ using <a href="https://caffeine.ai" target="_blank" rel="noopener noreferrer" className="underline hover:text-foreground transition-colors">caffeine.ai</a></p>
        </footer>
      </div>
    </div>
  );
}

export default App;
