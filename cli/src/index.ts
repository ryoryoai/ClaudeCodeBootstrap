#!/usr/bin/env node
import { Command } from "commander";
import { init } from "./commands/init.js";
import { update } from "./commands/update.js";
import { versions } from "./commands/versions.js";

const program = new Command();

program
  .name("claude-bootstrap")
  .description("CLI to install Claude Code Bootstrap configuration")
  .version("1.0.0");

program
  .command("init")
  .description("Initialize Claude Code Bootstrap in current directory")
  .option("-f, --force", "Overwrite existing files")
  .option("--version <version>", "Install specific version")
  .action(init);

program
  .command("update")
  .description("Update to the latest version")
  .option("-f, --force", "Force update even if up to date")
  .action(update);

program
  .command("versions")
  .description("List available versions")
  .action(versions);

program.parse();
