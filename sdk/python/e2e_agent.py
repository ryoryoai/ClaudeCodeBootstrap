"""
E2E Delivery Agent - Python SDK Example

This agent orchestrates the full delivery workflow:
harness-manager -> req-analyst -> implementer -> code-reviewer -> test-runner
"""

import asyncio
import os
from claude_agent_sdk import query, ClaudeAgentOptions, AgentDefinition, HookMatcher


# Define subagents matching .claude/agents/*.md
AGENTS = {
    "harness-manager": AgentDefinition(
        description="Maintains harness/* files, tracks progress. Does NOT implement code.",
        prompt="""You are the harness manager.
Read harness/PROGRESS.md and harness/FEATURES.json at session start.
Update them at session end. Keep scope aligned with spec/REQ.md.""",
        tools=["Read", "Glob", "Grep", "Edit"]
    ),
    "req-analyst": AgentDefinition(
        description="Produces implementation plan from spec/REQ.md.",
        prompt="""You are a requirements analyst.
Read spec/REQ.md and produce docs/IMPLEMENTATION_PLAN.md.
Include: Goal, Non-goals, Acceptance Criteria, Task breakdown, Test plan.""",
        tools=["Read", "Glob", "Grep", "Edit"]
    ),
    "implementer": AgentDefinition(
        description="Implements tasks from docs/IMPLEMENTATION_PLAN.md.",
        prompt="""You are a senior engineer.
Read docs/IMPLEMENTATION_PLAN.md and implement in small increments.
Add/adjust tests. Update docs/IMPLEMENTATION_REPORT.md.""",
        tools=["Read", "Glob", "Grep", "Edit", "Bash"]
    ),
    "code-reviewer": AgentDefinition(
        description="Read-only reviewer. Reviews for correctness, security, tests.",
        prompt="""You are a strict code reviewer.
Use git diff to identify changes. Focus on P0/P1 issues.
Never edit files. Provide actionable suggestions.""",
        tools=["Read", "Glob", "Grep", "Bash"]
    ),
    "test-runner": AgentDefinition(
        description="Runs full test suite and fixes failures until green.",
        prompt="""You are a test automation specialist.
Run ./scripts/ci.sh. If failures occur, fix and re-run until GREEN.
Update docs/TEST_REPORT.md.""",
        tools=["Read", "Glob", "Grep", "Edit", "Bash"]
    ),
}


async def log_tool_use(input_data, tool_use_id, context):
    """PostToolUse hook: Log all tool usage to harness/WORKLOG.md"""
    tool_name = input_data.get("tool_name", "unknown")
    print(f"[Hook] Tool used: {tool_name}")
    return {}


async def run_e2e_agent(task: str, session_id: str = None):
    """
    Run the E2E delivery agent.

    Args:
        task: The task to perform (e.g., "Implement login feature based on spec/REQ.md")
        session_id: Optional session ID to resume from
    """
    options = ClaudeAgentOptions(
        allowed_tools=["Read", "Glob", "Grep", "Edit", "Bash", "Task"],
        permission_mode="acceptEdits",
        agents=AGENTS,
        setting_sources=["project"],  # Load .claude/skills, CLAUDE.md, etc.
        hooks={
            "PostToolUse": [
                HookMatcher(matcher=".*", hooks=[log_tool_use])
            ]
        }
    )

    if session_id:
        options.resume = session_id

    captured_session_id = None

    async for message in query(prompt=task, options=options):
        # Capture session ID for later resumption
        if hasattr(message, 'subtype') and message.subtype == 'init':
            captured_session_id = message.session_id
            print(f"[Session] Started: {captured_session_id}")

        # Print results
        if hasattr(message, "result"):
            print(f"\n[Result]\n{message.result}")

        # Print assistant messages
        if hasattr(message, "content") and message.type == "assistant":
            for block in message.content:
                if hasattr(block, "text"):
                    print(block.text)

    return captured_session_id


async def main():
    """Example usage"""

    # Example 1: Start a new E2E delivery session
    print("=" * 60)
    print("E2E Delivery Agent")
    print("=" * 60)

    task = """
    Follow the E2E workflow defined in CLAUDE.md:
    1. Use harness-manager to check current progress
    2. Use req-analyst to create implementation plan from spec/REQ.md
    3. Use implementer to implement the plan
    4. Use code-reviewer to review changes
    5. Use test-runner to run tests until green
    6. Use harness-manager to update progress
    """

    session_id = await run_e2e_agent(task)

    print(f"\n[Session Complete] ID: {session_id}")
    print("To resume later, use: run_e2e_agent(task, session_id)")


if __name__ == "__main__":
    asyncio.run(main())
