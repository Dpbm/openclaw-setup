---
name: add_qplugin
description: A skill to add a plugin to qserver.
metadata:
  {
    "openclaw":
      {
        "emoji": "🔥",
        "requires": { "bins": ["curl"] },
      },
  }

---

# Add QPlugin Skill

When the user asks to add a plugin, Execute the following command:
`curl -X POST "$(echo $SERVER_URL)/api/v1/plugin/{{ plugin_name }}"`
