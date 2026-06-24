## Bash command descriptions
For any non-trivial Bash command — pipes, chains (&&/||/;), xargs,
find/grep with multiple flags, anything destructive (rm, mv, db writes),
or anything I can't read at a glance — write the tool's `description`
field as two short sentences:
1. WHAT it does, in plain English (decode the flags/pipes).
2. WHY you're running it right now — what it unblocks in the current task.
For trivial commands (ls, cd, git status, cat), a 2-4 word label is fine.
Never pad simple commands with a paragraph.
