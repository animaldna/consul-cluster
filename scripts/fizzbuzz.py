#!/usr/bin/python3
import json
import subprocess
import base64

def fizzBuzz(start, stop):
    kvs = []
    checks = [(3,"Fizz"), (5,"Buzz")]

    for i in range(start, stop):
        result = ""
        for c in checks:
            if i % c[0] == 0:
                result += c[1]

        if result == "":
            tmp = base64.b64encode(bytes(str(i), "ascii"))
        else:
            tmp = base64.b64encode(bytes(result, "ascii"))
        kvs.append(
                {
                    "key": f"hello/{i}",
                    "value":  tmp.decode('ascii')
                }
            )
    return kvs


if __name__ == ('__main__'):
    kvs = fizzBuzz(1,101)
    with open('kvs.json', 'w') as f:
        json.dump(kvs, f)

    subprocess.run("consul kv import @kvs.json", shell=True)