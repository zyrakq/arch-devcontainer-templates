## Brief overview
Detailed git workflow rules. Includes strict commit formatting requirements, workflow optimization, and API request conservation.

## Commit formatting
- Header no more than 50 characters, starts with verb in infinitive form
- Description "what was done" - mandatory, no more than 72 characters per line  
- Description "why it was done" - mandatory, no more than 72 characters per line
- Task reference in format "Task: [number](task_link)" - mandatory
- All descriptions in English language
- Blocks separated by empty lines
- Don't put period at end of line if there's no second sentence

## Mandatory pre-commit check
- If commit creation request doesn't specify task number and link, always ask user for them
- Task link format: "Task: [number](task_link)"

## API request conservation
- NEVER check commit header and description after creation
- Don't request confirmation of commit message correctness
- Don't suggest improvements to already created commit
- Execute git commit immediately without additional checks

## Workflow
- Before commit check change status via `git status`
- Add files via `git add` only those related to current task
- Create commit with single command without subsequent checks
- After commit immediately proceed to next task

## Git commands
- Use `git commit -m "message"` for quick commits
- For complex commits use `git commit` with editor opening
- Avoid `git commit --amend` after push
