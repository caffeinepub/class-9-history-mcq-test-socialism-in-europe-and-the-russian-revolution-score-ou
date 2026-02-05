import type { Principal } from "@icp-sdk/core/principal";
export interface Some<T> {
    __kind__: "Some";
    value: T;
}
export interface None {
    __kind__: "None";
}
export type Option<T> = Some<T> | None;
export interface MCQ {
    topic: Topic;
    question: string;
    difficulty: Difficulty;
    correctAnswerIndex: bigint;
    options: Array<string>;
}
export interface Answer {
    questionIndex: bigint;
    selectedOption: bigint;
}
export enum Difficulty {
    easy = "easy",
    hard = "hard",
    medium = "medium"
}
export enum Topic {
    russianEmpire = "russianEmpire",
    februaryRevolution = "februaryRevolution",
    afterFebruary = "afterFebruary"
}
export interface backendInterface {
    getQuestions(): Promise<Array<MCQ>>;
    submitAnswers(answers: Array<Answer>): Promise<bigint>;
}
