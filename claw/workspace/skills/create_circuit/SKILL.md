---
name: create_circuit
description: A skill to generate qasm files.
metadata:
  {
    "openclaw":
      {
        "emoji": "🧅",
      },
  }
---

# Create Circuit Skill

When the user asks to create a quantum circuit. First, you'll generate the circuit in the `openqasm` format and save it at `/home/node/shared/{{ circuit_name }}-$(date --date="now").qasm`, for it you must use the Exec and Write tools.

Then, you will output for the user in the following format:

```
# {{ circuit_name }} Algorithm

---

Who created it: { add the main authors of this algorithm here }
Papers: { Papers which explain it }

---

{ explain the algorithm itself here }

---

{ show the qasm code here }

```