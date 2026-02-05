import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { useActor } from './useActor';
import type { MCQ, Answer } from '../backend';

export function useGetQuestions() {
  const { actor, isFetching } = useActor();

  return useQuery<MCQ[]>({
    queryKey: ['questions'],
    queryFn: async () => {
      if (!actor) return [];
      return actor.getQuestions();
    },
    enabled: !!actor && !isFetching,
  });
}

export function useSubmitAnswers() {
  const { actor } = useActor();
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (answers: Answer[]) => {
      if (!actor) throw new Error('Actor not initialized');
      return actor.submitAnswers(answers);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['questions'] });
    },
  });
}
