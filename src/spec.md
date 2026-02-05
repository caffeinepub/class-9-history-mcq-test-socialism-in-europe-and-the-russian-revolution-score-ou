# Specification

## Summary
**Goal:** Provide a Class 9 History MCQ test for “Socialism in Europe and the Russian Revolution” (focused on WWI & Russian Empire, February Revolution & Petrograd, and After February) with a complete start-to-finish flow and a final score out of 50.

**Planned changes:**
- Backend: Add a question bank (topic, difficulty, options, correct answer) in a single Motoko actor and expose an API to fetch questions without correct answers.
- Backend: Add a scoring API that accepts submitted answers and returns a deterministic “Score: X / 50”.
- Frontend: Build a 3-screen quiz UI (start, question flow, end) with single-choice selection, navigation, and restart.
- Frontend: Ensure questions progress from easy to hard across the test.
- Frontend: Apply a consistent visual theme (colors/typography/layout) that avoids a blue/purple primary palette.
- Frontend: Add and display the generated static banner image asset from `frontend/public/assets/generated`.

**User-visible outcome:** Users can start the Class 9 History quiz, answer single-choice MCQs in an easy-to-hard sequence, finish the test, and see their final score displayed as “Score: X / 50”, with an option to restart.
