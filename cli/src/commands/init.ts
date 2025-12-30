import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import chalk from "chalk";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ASSETS_DIR = path.resolve(__dirname, "../../assets");

interface InitOptions {
  force?: boolean;
  version?: string;
}

export async function init(options: InitOptions) {
  const targetDir = process.cwd();
  const claudeDir = path.join(targetDir, ".claude");

  console.log(chalk.blue("ClaudeCodeOrchestrator (CCOrch)"));
  console.log();

  // Check if .claude already exists
  if (fs.existsSync(claudeDir) && !options.force) {
    console.log(chalk.yellow("⚠ .claude directory already exists."));
    console.log(chalk.gray("  Use --force to overwrite."));
    process.exit(1);
  }

  // Copy assets
  const sourceDir = path.join(ASSETS_DIR, ".claude");

  if (!fs.existsSync(sourceDir)) {
    console.log(chalk.red("✗ Assets not found. Please reinstall the package."));
    process.exit(1);
  }

  console.log(chalk.gray("Installing to: " + targetDir));
  console.log();

  try {
    copyDirSync(sourceDir, claudeDir);

    console.log(chalk.green("✓ .claude/settings.json"));
    console.log(chalk.green("✓ .claude/skills/"));
    console.log(chalk.green("✓ .claude/agents/"));
    console.log(chalk.green("✓ .claude/commands/"));
    console.log(chalk.green("✓ .claude/hooks/"));
    console.log();
    console.log(chalk.green("✓ ClaudeCodeOrchestrator installed successfully!"));
    console.log();
    console.log(chalk.gray("Next steps:"));
    console.log(chalk.gray("  1. Open the project in VS Code / Cursor"));
    console.log(chalk.gray("  2. Start Claude Code"));
    console.log(chalk.gray("  3. Use /start-session to begin"));
  } catch (error) {
    console.log(chalk.red("✗ Failed to install: " + (error as Error).message));
    process.exit(1);
  }
}

function copyDirSync(src: string, dest: string) {
  fs.mkdirSync(dest, { recursive: true });

  const entries = fs.readdirSync(src, { withFileTypes: true });

  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);

    if (entry.isDirectory()) {
      copyDirSync(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}
