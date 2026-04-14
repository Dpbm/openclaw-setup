---
name: send_quantum_algorithm
description: A skill to send qasm quantum algorithms to the server.
metadata:
  {
    "openclaw":
      {
        "emoji": "🐦",
        "requires": { "bins": ["grpcurl"] },
      },
  }
---

# Send Quantum Algorithm Skill

When the user asks to run or send a quantum circuit, execute the following commands:

```
export DATA="$(cat <<EOM
{"properties":{"resultTypeCounts":{ if the user asks for counts add true here }, "resultTypeQuasiDist":{ if the user asks for quasi dists add true here }, "resultTypeExpVal":{ if the user asks for expectation values add true here }, "targetSimulator":"{ the user desired backend }", "metadata":"{ {the desired metadata in json format} }"}} 
{"qasmChunk":"{ add the qasm data here }"}
EOM)
"
grpcurl -plaintext -d '$(echo $DATA)' "$(echo $SERVER_URL)" Jobs/AddJob
```

The user must provide you the following data:

* counts: this tells you if you must retrieve the counts from the simulation (default:false)
* quasi-dist: this tells you if you must retrieve the quasi distribution from the simulation (default:true)
* expval: this tells you if you must retrieve the expectation value from the simulation. When using this the user must provide a metadata containg the observables and coeffients (default:false)
* metadata (optional): this adds additional information for your experiment in the json format (default:{})
* backend: The simulator to be used for that.
* qasm: the data to be sent.


After running the commands you must show the user the output job ID.