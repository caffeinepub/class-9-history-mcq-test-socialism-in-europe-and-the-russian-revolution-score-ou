import List "mo:core/List";
import Text "mo:core/Text";
import Order "mo:core/Order";
import Iter "mo:core/Iter";
import Array "mo:core/Array";

actor {
  type Difficulty = { #easy; #medium; #hard };
  type Topic = {
    #russianEmpire;
    #februaryRevolution;
    #afterFebruary;
  };

  type MCQ = {
    question : Text;
    options : [Text];
    correctAnswerIndex : Nat;
    difficulty : Difficulty;
    topic : Topic;
  };

  type Answer = {
    questionIndex : Nat;
    selectedOption : Nat;
  };

  let mcqBank = List.empty<MCQ>();

  func populateMCQs() {
    // Russian Empire (Easy)
    mcqBank.add(
      {
        question = "Who ruled Russia before the February Revolution?";
        options = ["Tsar Nicholas II", "Karl Marx", "Leon Trotsky", "Vladimir Lenin"];
        correctAnswerIndex = 0;
        difficulty = #easy;
        topic = #russianEmpire;
      }
    );

    mcqBank.add(
      {
        question = "Which social class formed the majority of the Russian population before 1917?";
        options = ["Nobility", "Peasants", "Bourgeoisie", "Clergy"];
        correctAnswerIndex = 1;
        difficulty = #easy;
        topic = #russianEmpire;
      }
    );

    // Russian Empire (Medium)
    mcqBank.add(
      {
        question = "The 'Bloody Sunday' event in 1905 led to:";
        options = [
          "The abdication of the Tsar",
          "The creation of the Duma",
          "The Bolshevik Revolution",
          "The end of serfdom"
        ];
        correctAnswerIndex = 1;
        difficulty = #medium;
        topic = #russianEmpire;
      }
    );

    // Russian Empire (Hard)
    mcqBank.add(
      {
        question = "The Mensheviks and Bolsheviks disagreed primarily on:";
        options = [
          "The participation of workers in the government",
          "The pace and method of revolution",
          "The role of the monarchy",
          "The expansion of Russian territory"
        ];
        correctAnswerIndex = 1;
        difficulty = #hard;
        topic = #russianEmpire;
      }
    );

    // February Revolution (Easy)
    mcqBank.add(
      {
        question = "The February Revolution was named after:";
        options = ["The Russian calendar", "The Gregorian calendar", "The month it began worldwide",
                   "The anniversary of the Tsar's coronation"];
        correctAnswerIndex = 0;
        difficulty = #easy;
        topic = #februaryRevolution;
      }
    );

    // February Revolution (Medium)
    mcqBank.add(
      {
        question = "Which city played a central role in the February Revolution?";
        options = ["Moscow", "Stalingrad", "Petrograd", "Kiev"];
        correctAnswerIndex = 2;
        difficulty = #medium;
        topic = #februaryRevolution;
      }
    );

    // February Revolution (Hard)
    mcqBank.add(
      {
        question = "Which of the following was a major consequence of the February Revolution?";
        options = [
          "The establishment of the Soviet Union",
          "The abdication of the Tsar and formation of the Provisional Government",
          "The start of the Red Army",
          "The end of World War I"
        ];
        correctAnswerIndex = 1;
        difficulty = #hard;
        topic = #februaryRevolution;
      }
    );

    // After February (Easy)
    mcqBank.add(
      {
        question = "Who became the leader of the Bolshevik Party after the February Revolution?";
        options = ["Trotsky", "Kerensky", "Stalin", "Lenin"];
        correctAnswerIndex = 3;
        difficulty = #easy;
        topic = #afterFebruary;
      }
    );

    // After February (Medium)
    mcqBank.add(
      {
        question = "The Provisional Government faced challenges because:";
        options = [
          "It ended the war immediately",
          "It failed to address land reforms",
          "It suppressed political parties",
          "It eliminated the Soviets"
        ];
        correctAnswerIndex = 1;
        difficulty = #medium;
        topic = #afterFebruary;
      }
    );

    // After February (Hard)
    mcqBank.add(
      {
        question = "The Bolsheviks' seizure of power in October 1917 was mostly due to:";
        options = [
          "Popular support for the monarchy",
          "Coordination with the Provisional Government",
          "Discontent with the ongoing war and land policies",
          "The influence of foreign governments"
        ];
        correctAnswerIndex = 2;
        difficulty = #hard;
        topic = #afterFebruary;
      }
    );
  };

  // Initialize MCQ bank
  populateMCQs();

  module MCQ {
    public func compare(a : MCQ, b : MCQ) : Order.Order {
      // Simple comparison based on question text
      Text.compare(a.question, b.question);
    };
  };

  public query ({ caller }) func getQuestions() : async [MCQ] {
    // Sort MCQs by difficulty (easy to hard)
    mcqBank.toArray().sort();
  };

  public shared ({ caller }) func submitAnswers(answers : [Answer]) : async Nat {
    var score = 0;

    for (ans in answers.values()) {
      if (ans.questionIndex < mcqBank.size()) {
        let mcq = mcqBank.at(ans.questionIndex);
        if (ans.selectedOption == mcq.correctAnswerIndex) {
          switch (mcq.difficulty) {
            case (#easy) { score += 5 };
            case (#medium) { score += 10 };
            case (#hard) { score += 15 };
          };
        };
      };
    };

    if (score > 50) { score := 50 };
    score;
  };
};
