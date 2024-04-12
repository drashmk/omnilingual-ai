import 'package:chat/model/ai_model.dart';

const Set<AiModel> aiModels = {
  AiModel(code: '@cf/meta/llama-2-7b-chat-int8', name: 'llama-2-7b-chat-int8'),
  AiModel(code: '@cf/meta/llama-2-7b-chat-fp16', name: 'llama-2-7b-chat-fp16'),
  AiModel(
      code: '@cf/mistral/mistral-7b-instruct-v0.1',
      name: 'mistral-7b-instruct-v0.1'),
  AiModel(
      code: '@cf/deepseek-ai/deepseek-math-7b-base',
      name: 'deepseek-math-7b-base'),
  AiModel(
      code: '@cf/deepseek-ai/deepseek-math-7b-instruct',
      name: 'deepseek-math-7b-instruct'),
  AiModel(code: '@cf/defog/sqlcoder-7b-2', name: 'sqlcoder-7b-2'),
  AiModel(code: '@cf/microsoft/phi-2', name: 'phi-2'),
  AiModel(code: '@cf/openchat/openchat-3.5-0106', name: 'openchat-3.5-0106'),
  AiModel(code: '@cf/qwen/qwen1.5-0.5b-chat', name: 'qwen1.5-0.5b-chat'),
  AiModel(code: '@cf/qwen/qwen1.5-1.8b-chat', name: 'qwen1.5-1.8b-chat'),
  AiModel(code: '@cf/qwen/qwen1.5-14b-chat-awq', name: 'qwen1.5-14b-chat-awq'),
  AiModel(code: '@cf/qwen/qwen1.5-7b-chat-awq', name: 'qwen1.5-7b-chat-awq'),
  AiModel(
      code: '@cf/thebloke/discolm-german-7b-v1-awq',
      name: 'discolm-german-7b-v1-awq'),
  AiModel(code: '@cf/tiiuae/falcon-7b-instruct', name: 'falcon-7b-instruct'),
  AiModel(
      code: '@cf/tinyllama/tinyllama-1.1b-chat-v1.0',
      name: 'tinyllama-1.1b-chat-v1.0'),
  AiModel(
      code: '@hf/thebloke/codellama-7b-instruct-awq',
      name: 'codellama-7b-instruct-awq'),
  AiModel(
      code: '@hf/thebloke/deepseek-coder-6.7b-base-awq',
      name: 'deepseek-coder-6.7b-base-awq'),
  AiModel(
      code: '@hf/thebloke/deepseek-coder-6.7b-instruct-awq',
      name: 'deepseek-coder-6.7b-instruct-awq'),
  AiModel(
      code: '@hf/thebloke/llama-2-13b-chat-awq', name: 'llama-2-13b-chat-awq'),
  AiModel(code: '@hf/thebloke/llamaguard-7b-awq', name: 'llamaguard-7b-awq'),
  AiModel(
      code: '@hf/thebloke/mistral-7b-instruct-v0.1-awq',
      name: 'mistral-7b-instruct-v0.1-awq'),
  AiModel(
      code: '@hf/thebloke/neural-chat-7b-v3-1-awq',
      name: 'neural-chat-7b-v3-1-awq'),
  AiModel(code: '@hf/thebloke/openchat_3.5-awq', name: 'openchat_3.5-awq'),
  AiModel(
      code: '@hf/thebloke/openhermes-2.5-mistral-7b-awq',
      name: 'openhermes-2.5-mistral-7b-awq'),
  AiModel(code: '@hf/thebloke/orca-2-13b-awq', name: 'orca-2-13b-awq'),
  AiModel(code: '@hf/thebloke/zephyr-7b-beta-awq', name: 'zephyr-7b-beta-awq'),
};
