"""
Simple Agent Example - Python SDK

A minimal example showing how to use the Agent SDK.
"""

import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions


async def main():
    """Run a simple agent that explores the codebase"""

    print("Starting simple agent...")

    async for message in query(
        prompt="What files are in this project? Summarize the structure.",
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Glob", "Grep", "Bash"],
            permission_mode="bypassPermissions",  # Read-only, no confirmation needed
            setting_sources=["project"]  # Load CLAUDE.md and skills
        )
    ):
        if hasattr(message, "result"):
            print(message.result)


if __name__ == "__main__":
    asyncio.run(main())
