import List "mo:core/List";
import Text "mo:core/Text";
import Iter "mo:core/Iter";
import Order "mo:core/Order";
import Nat "mo:core/Nat";

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
        question = "1. Who ruled Russia before the February Revolution?";
        options = ["Tsar Nicholas II", "Karl Marx", "Leon Trotsky", "Vladimir Lenin"];
        correctAnswerIndex = 0;
        difficulty = #easy;
        topic = #russianEmpire;
      }
    );
    mcqBank.add(
      {
        question = "2. Which social class formed the majority of the Russian population before 1917?";
        options = ["Nobility", "Peasants", "Bourgeoisie", "Clergy"];
        correctAnswerIndex = 1;
        difficulty = #easy;
        topic = #russianEmpire;
      }
    );
    mcqBank.add(
      {
        question = "3. The term 'soviets' referred to:";
        options = ["Noble families", "Worker's councils", "Religious leaders", "Tsar's advisors"];
        correctAnswerIndex = 1;
        difficulty = #easy;
        topic = #russianEmpire;
      }
    );

    // Russian Empire (Medium)
    mcqBank.add(
      {
        question = "4. The 'Bloody Sunday' event in 1905 led to:";
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

    mcqBank.add(
      {
        question = "5. The Mensheviks and Bolsheviks disagreed primarily on:";
        options = [
          "The participation of workers in the government",
          "The pace and method of revolution",
          "The role of the monarchy",
          "The expansion of Russian territory"
        ];
        correctAnswerIndex = 1;
        difficulty = #medium;
        topic = #russianEmpire;
      }
    );

    // Russian Empire (Hard)
    mcqBank.add(
      {
        question = "6. The Bolsheviks' ideology was most influenced by:";
        options = ["Adam Smith", "Karl Marx", "John Locke", "Herbert Spencer"];
        correctAnswerIndex = 1;
        difficulty = #hard;
        topic = #russianEmpire;
      }
    );

    // February Revolution (Easy)
    mcqBank.add(
      {
        question = "7. The February Revolution was named after:";
        options = [
          "The Russian calendar",
          "The Gregorian calendar",
          "Worldwide events",
          "Tsar's coronation"
        ];
        correctAnswerIndex = 0;
        difficulty = #easy;
        topic = #februaryRevolution;
      }
    );
    mcqBank.add(
      {
        question = "8. Which city played a central role in the February Revolution?";
        options = ["Moscow", "Stalingrad", "Petrograd", "Kiev"];
        correctAnswerIndex = 2;
        difficulty = #easy;
        topic = #februaryRevolution;
      }
    );

    // February Revolution (Medium)
    mcqBank.add(
      {
        question = "9. A major outcome of the February Revolution was:";
        options = [
          "Soviet Union founding",
          "Tsar's abdication",
          "Red Army formation",
          "WWI's end"
        ];
        correctAnswerIndex = 1;
        difficulty = #medium;
        topic = #februaryRevolution;
      }
    );
    mcqBank.add(
      {
        question = "10. Women's protests during the February Revolution were mainly for:";
        options = ["Suffrage", "Food and bread", "Equal pay", "Peace"];
        correctAnswerIndex = 1;
        difficulty = #medium;
        topic = #februaryRevolution;
      }
    );

    // February Revolution (Hard)
    mcqBank.add(
      {
        question = "11. The dual power in Russia after the February Revolution referred to:";
        options = [
          "Monarchy vs. Parliament",
          "Provisional Government vs. Soviets",
          "Church vs. State",
          "Workers vs. Peasants"
        ];
        correctAnswerIndex = 1;
        difficulty = #hard;
        topic = #februaryRevolution;
      }
    );

    // After February (Easy)
    mcqBank.add(
      {
        question = "12. Who became the leader of the Bolshevik Party after the February Revolution?";
        options = ["Trotsky", "Kerensky", "Stalin", "Lenin"];
        correctAnswerIndex = 3;
        difficulty = #easy;
        topic = #afterFebruary;
      }
    );
    mcqBank.add(
      {
        question = "13. The Provisional Government faced challenges because:";
        options = [
          "Immediate war ending",
          "Failed land reforms",
          "Suppressed politics",
          "Eliminated Soviets"
        ];
        correctAnswerIndex = 1;
        difficulty = #easy;
        topic = #afterFebruary;
      }
    );

    // After February (Medium)
    mcqBank.add(
      {
        question = "14. The Bolsheviks' October 1917 power seizure was mainly due to:";
        options = [
          "Monarchy support",
          "Provisional Government cooperation",
          "War and land policy discontent",
          "Foreign influence"
        ];
        correctAnswerIndex = 2;
        difficulty = #medium;
        topic = #afterFebruary;
      }
    );
    mcqBank.add(
      {
        question = "15. 'Peace, Land, and Bread' was a slogan for:";
        options = ["Mensheviks", "Bolsheviks", "Tsar", "Kerensky"];
        correctAnswerIndex = 1;
        difficulty = #medium;
        topic = #afterFebruary;
      }
    );

    // After February (Hard)
    mcqBank.add(
      {
        question = "16. The Treaty of Brest-Litovsk ended:";
        options = [
          "World War I",
          "Russia's involvement in WWI",
          "Civil War",
          "Tsarism"
        ];
        correctAnswerIndex = 1;
        difficulty = #hard;
        topic = #afterFebruary;
      }
    );

    // Additional Questions
    mcqBank.add(
      {
        question = "17. Role of soviets after February 1917:";
        options = [
          "Labor unions",
          "Parallel authority",
          "Religious entities",
          "Foreign councils"
        ];
        correctAnswerIndex = 1;
        difficulty = #medium;
        topic = #afterFebruary;
      }
    );
    mcqBank.add(
      {
        question = "18. Bolsheviks differed from other socialist groups by:";
        options = [
          "Immediate revolution",
          "Parliamentary work",
          "Provisional Government support",
          "Gradual reforms"
        ];
        correctAnswerIndex = 0;
        difficulty = #hard;
        topic = #afterFebruary;
      }
    );

    mcqBank.add(
      {
        question = "19. The Duma was established after:";
        options = ["October Revolution", "1905 tsarist reforms", "February Revolution", "WWI"];
        correctAnswerIndex = 1;
        difficulty = #easy;
        topic = #russianEmpire;
      }
    );

    mcqBank.add(
      {
        question = "20. Peasant land demand after February Revolution:";
        options = [
          "Maintain large estates",
          "Absentee landownership",
          "Land redistribution",
          "Collective farming"
        ];
        correctAnswerIndex = 2;
        difficulty = #medium;
        topic = #afterFebruary;
      }
    );

    mcqBank.add(
      {
        question = "21. Bolshevik promise of 'control of factories' referred to:";
        options = [
          "Soviet takeovers",
          "Government nationalization",
          "Worker control",
          "Foreign investments"
        ];
        correctAnswerIndex = 2;
        difficulty = #hard;
        topic = #afterFebruary;
      }
    );

    mcqBank.add(
      {
        question = "22. The Provisional Government's decision to continue WWI:";
        options = [
          "Increased support",
          "Decreased support",
          "Led to peace treaty",
          "Helped peasants"
        ];
        correctAnswerIndex = 1;
        difficulty = #medium;
        topic = #afterFebruary;
      }
    );

    mcqBank.add(
      {
        question = "23. The Bolsheviks gained support from workers and peasants by:";
        options = [
          "Promising land and peace",
          "Supporting monarchy",
          "Aligning with Mensheviks",
          "Ignoring demands"
        ];
        correctAnswerIndex = 0;
        difficulty = #medium;
        topic = #afterFebruary;
      }
    );

    mcqBank.add(
      {
        question = "24. Lenin returned to Russia in 1917 from:";
        options = ["France", "Switzerland", "Germany", "England"];
        correctAnswerIndex = 1;
        difficulty = #easy;
        topic = #afterFebruary;
      }
    );

    mcqBank.add(
      {
        question = "25. The main goal of the Bolshevik Revolution was:";
        options = [
          "Establish communism",
          "Support monarchy",
          "Expand territory",
          "Maintain status quo"
        ];
        correctAnswerIndex = 0;
        difficulty = #hard;
        topic = #afterFebruary;
      }
    );
  };

  // Initialize MCQ bank
  populateMCQs();

  func compareDifficulty(a : Difficulty, b : Difficulty) : Order.Order {
    switch (a, b) {
      case (#easy, #easy) { #equal };
      case (#easy, _) { #less };
      case (#medium, #easy) { #greater };
      case (#medium, #medium) { #equal };
      case (#medium, #hard) { #less };
      case (#hard, #hard) { #equal };
      case (#hard, _) { #greater };
    };
  };

  module MCQ {
    public func compare(a : MCQ, b : MCQ) : Order.Order {
      switch (compareDifficulty(a.difficulty, b.difficulty)) {
        case (#less) { #less };
        case (#greater) { #greater };
        case (#equal) { Text.compare(a.question, b.question) };
      };
    };
  };

  public query ({ caller }) func getQuestions() : async [MCQ] {
    // Sort MCQs by difficulty (easy to hard)
    mcqBank.toArray().sort(func(a, b) { MCQ.compare(a, b) });
  };

  public shared ({ caller }) func submitAnswers(answers : [Answer]) : async Nat {
    var score = 0;

    for (ans in answers.values()) {
      if (ans.questionIndex < mcqBank.size()) {
        let mcq = mcqBank.at(ans.questionIndex);
        if (ans.selectedOption == mcq.correctAnswerIndex) {
          score += 2;
        };
      };
    };
    if (score > 50) { 50 } else { score };
  };
};
