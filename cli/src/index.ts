#!/usr/bin/env node
import { Command } from "commander";
import { init } from "./commands/init.js";

const program = new Command();

program
  .name("create-ccb")
  .description("Claude Code Bootstrap - Setup your Claude Code configuration")
  .version("1.0.0");

program
  .option("-f, --force", "Overwrite existing files")
  .option("-v, --ver <version>", "Install specific version")
  .action(init);

program.parse();
