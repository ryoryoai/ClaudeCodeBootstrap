import chalk from "chalk";
import { execSync } from "child_process";

export async function versions() {
  console.log(chalk.blue("Available versions:"));
  console.log();

  try {
    const versionsRaw = execSync("npm view claude-bootstrap-cli versions --json", {
      encoding: "utf-8",
    });

    const versionsList = JSON.parse(versionsRaw) as string[];

    // Show last 10 versions
    const recent = versionsList.slice(-10).reverse();

    for (const v of recent) {
      console.log(chalk.gray(`  ${v}`));
    }

    if (versionsList.length > 10) {
      console.log(chalk.gray(`  ... and ${versionsList.length - 10} more`));
    }

    console.log();
    console.log(chalk.gray("Install specific version:"));
    console.log(chalk.gray("  claude-bootstrap init --version <version>"));
  } catch (error) {
    // Package not yet published
    console.log(chalk.yellow("  Package not yet published to npm."));
    console.log(chalk.gray("  Local version available."));
  }
}
