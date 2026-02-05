# Specification

## Summary
**Goal:** Expand the existing Class 9 History quiz question bank to exactly 25 MCQs with a consistent easy → medium → hard progression while keeping the final score reported out of 50.

**Planned changes:**
- Update the backend in-memory MCQ question bank to include exactly 25 questions for “Socialism in Europe and the Russian Revolution” spanning the existing topics (#russianEmpire, #februaryRevolution, #afterFebruary) with an easy → medium → hard progression.
- Ensure `getQuestions()` returns questions in deterministic order: all easy first, then medium, then hard, with a stable tie-break for same-difficulty questions.
- Adjust backend scoring so a perfect 25/25 attempt yields exactly 50 points (and 0/25 yields 0), without applying a hard cap.

**User-visible outcome:** Users can take a 25-question History quiz that reliably progresses from easier to harder questions and still reports a final score out of 50.
