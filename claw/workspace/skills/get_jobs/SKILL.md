---
name: get_jobs
description: A skill to list quantum jobs from qserver.
metadata:
  {
    "openclaw":
      {
        "emoji": "🫪",
        "requires": { "bins": ["curl", "jq"] },
      },
  }
---

# Get Jobs Skill

When the user asks to list his jobs, Execute the following command:
`curl "$(echo $SERVER_URL)/api/v1/jobs" | jq`

Show him the output of the command.
