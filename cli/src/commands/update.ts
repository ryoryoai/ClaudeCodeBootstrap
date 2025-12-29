import chalk from "chalk";
import { execSync } from "child_process";

interface UpdateOptions {
  force?: boolean;
}

export async function update(options: UpdateOptions) {
  console.log(chalk.blue("Checking for updates..."));
  console.log();

  try {
    // Get current version
    const pkg = await import("../../package.json", { assert: { type: "json" } });
    const currentVersion = pkg.default.version;

    // Check npm for latest version
    const latestVersion = execSync("npm view claude-bootstrap-cli version", {
      encoding: "utf-8",
    }).trim();

    if (currentVersion === latestVersion && !options.force) {
      console.log(chalk.green(`✓ Already on latest version (${currentVersion})`));
      return;
    }

    console.log(chalk.gray(`Current: ${currentVersion}`));
    console.log(chalk.gray(`Latest:  ${latestVersion}`));
    console.log();

    console.log(chalk.blue("Updating..."));
    execSync("npm install -g claude-bootstrap-cli@latest", { stdio: "inherit" });

    console.log();
    console.log(chalk.green("✓ Updated successfully!"));
    console.log(chalk.gray("  Run 'claude-bootstrap init --force' to update your project."));
  } catch (error) {
    console.log(chalk.red("✗ Failed to update: " + (error as Error).message));
    process.exit(1);
  }
}
