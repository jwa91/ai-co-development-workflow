# Project Context Collector

This simple shell script helps you quickly collect and share the context of your development project with an AI language model. It's designed to streamline your workflow when working with AI assistants on coding tasks. It let's you quickly cherrypick the specific context off the project for your question to the LLM, as sharing the entire project in my opinion results in worse output and far greater token usage.

## Features

- Automatically collects specified files and directories
- Converts file content to markdown format
- Calculates character and token counts
- Copies output to clipboard and saves to a file
- Supports optional inclusion of project structure

## Prerequisites

- Zsh shell
- macOS (for the `pbcopy` command)
- Basic command-line tools: `wc`, `tr`, `cat`, `rm`

## Setup

1. download the `file2md.sh` script.
2. Make the script executable:

   ```
   chmod +x file2md.sh
   ```

3. Place the script in a convenient location, preferably in your project root or in a directory in your PATH. (I always use a `dev` folder in the root of my project).
   _Note: you could offcourse also opt for a shell alias, but i havent done that yet as i am still optimizing this workflow quite a bit_

## Usage

1. Create a `files.txt` in the same directory as the script, listing the files and directories you want to include, one per line.

2. (Optional) Create a `structure.md` file in the same directory to describe your project structure. (See Svelte example I used recently)

3. Create an `instructions.md` file in the same directory with any specific instructions or notes for the AI.

4. Run the script:

   ```
   ./file2md.sh
   ```

   To include the project structure, use the `-s` flag:

   ```
   ./file2md.sh -s
   ```

5. The script will process the files/folders, generate an `output.md` file, and copy the content to your clipboard.
   _note: when passing in a folder to the files.txt the script will go through each file in this folder, but will do so non-recursively._

## Output

- Console output showing processed files and total character/token counts
- `output.md` file containing all collected information
- Clipboard content for easy pasting into AI chat interfaces

![Voorbeeld output](static/example-output.png)

## Customization

- Modify the `files.txt` to include different files or directories
- Update `structure.md` to reflect your project's specific structure
- Adjust `instructions.md` to provide custom instructions for the AI

## Troubleshooting

- Ensure all paths in `files.txt` are correct and accessible
- Check file permissions if you encounter "could not open/read" errors
- Verify that all required commands (`wc`, `tr`, `cat`, `pbcopy`) are available on your system

## Tips

I am quite happy to hear about other/better ways of doing this sort of thing.
