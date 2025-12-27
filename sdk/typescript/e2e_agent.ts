/**
 * E2E Delivery Agent - TypeScript SDK Example
 *
 * This agent orchestrates the full delivery workflow:
 * harness-manager -> req-analyst -> implementer -> code-reviewer -> test-runner
 */

import {
  query,
  ClaudeAgentOptions,
  AgentDefinition,
  HookCallback,
} from '@anthropic-ai/claude-agent-sdk';

// Define subagents matching .claude/agents/*.md
const agents: Record<string, AgentDefinition> = {
  'harness-manager': {
    description: 'Maintains harness/* files, tracks progress. Does NOT implement code.',
    prompt: `You are the harness manager.
Read harness/PROGRESS.md and harness/FEATURES.json at session start.
Update them at session end. Keep scope aligned with spec/REQ.md.`,
    tools: ['Read', 'Glob', 'Grep', 'Edit'],
  },
  'req-analyst': {
    description: 'Produces implementation plan from spec/REQ.md.',
    prompt: `You are a requirements analyst.
Read spec/REQ.md and produce docs/IMPLEMENTATION_PLAN.md.
Include: Goal, Non-goals, Acceptance Criteria, Task breakdown, Test plan.`,
    tools: ['Read', 'Glob', 'Grep', 'Edit'],
  },
  implementer: {
    description: 'Implements tasks from docs/IMPLEMENTATION_PLAN.md.',
    prompt: `You are a senior engineer.
Read docs/IMPLEMENTATION_PLAN.md and implement in small increments.
Add/adjust tests. Update docs/IMPLEMENTATION_REPORT.md.`,
    tools: ['Read', 'Glob', 'Grep', 'Edit', 'Bash'],
  },
  'code-reviewer': {
    description: 'Read-only reviewer. Reviews for correctness, security, tests.',
    prompt: `You are a strict code reviewer.
Use git diff to identify changes. Focus on P0/P1 issues.
Never edit files. Provide actionable suggestions.`,
    tools: ['Read', 'Glob', 'Grep', 'Bash'],
  },
  'test-runner': {
    description: 'Runs full test suite and fixes failures until green.',
    prompt: `You are a test automation specialist.
Run ./scripts/ci.sh. If failures occur, fix and re-run until GREEN.
Update docs/TEST_REPORT.md.`,
    tools: ['Read', 'Glob', 'Grep', 'Edit', 'Bash'],
  },
};

// PostToolUse hook: Log all tool usage
const logToolUse: HookCallback = async (input) => {
  const toolName = (input as any).tool_name ?? 'unknown';
  console.log(`[Hook] Tool used: ${toolName}`);
  return {};
};

/**
 * Run the E2E delivery agent.
 */
async function runE2EAgent(task: string, sessionId?: string): Promise<string | undefined> {
  const options: ClaudeAgentOptions = {
    allowedTools: ['Read', 'Glob', 'Grep', 'Edit', 'Bash', 'Task'],
    permissionMode: 'acceptEdits',
    agents,
    settingSources: ['project'], // Load .claude/skills, CLAUDE.md, etc.
    hooks: {
      PostToolUse: [{ matcher: '.*', hooks: [logToolUse] }],
    },
  };

  if (sessionId) {
    options.resume = sessionId;
  }

  let capturedSessionId: string | undefined;

  for await (const message of query({ prompt: task, options })) {
    // Capture session ID for later resumption
    if (message.type === 'system' && message.subtype === 'init') {
      capturedSessionId = message.session_id;
      console.log(`[Session] Started: ${capturedSessionId}`);
    }

    // Print results
    if ('result' in message) {
      console.log(`\n[Result]\n${message.result}`);
    }

    // Print assistant messages
    if (message.type === 'assistant' && 'content' in message) {
      for (const block of message.content as any[]) {
        if (block.text) {
          console.log(block.text);
        }
      }
    }
  }

  return capturedSessionId;
}

// Main
async function main() {
  console.log('='.repeat(60));
  console.log('E2E Delivery Agent');
  console.log('='.repeat(60));

  const task = `
    Follow the E2E workflow defined in CLAUDE.md:
    1. Use harness-manager to check current progress
    2. Use req-analyst to create implementation plan from spec/REQ.md
    3. Use implementer to implement the plan
    4. Use code-reviewer to review changes
    5. Use test-runner to run tests until green
    6. Use harness-manager to update progress
  `;

  const sessionId = await runE2EAgent(task);

  console.log(`\n[Session Complete] ID: ${sessionId}`);
  console.log('To resume later, use: runE2EAgent(task, sessionId)');
}

main().catch(console.error);
