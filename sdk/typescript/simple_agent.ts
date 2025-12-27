/**
 * Simple Agent Example - TypeScript SDK
 *
 * A minimal example showing how to use the Agent SDK.
 */

import { query } from '@anthropic-ai/claude-agent-sdk';

async function main() {
  console.log('Starting simple agent...');

  for await (const message of query({
    prompt: 'What files are in this project? Summarize the structure.',
    options: {
      allowedTools: ['Read', 'Glob', 'Grep', 'Bash'],
      permissionMode: 'bypassPermissions', // Read-only, no confirmation needed
      settingSources: ['project'], // Load CLAUDE.md and skills
    },
  })) {
    if ('result' in message) {
      console.log(message.result);
    }
  }
}

main().catch(console.error);
