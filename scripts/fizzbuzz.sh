#!/bin/bash

function checkDivis {
    return $(($1 % $2))
}

function fizzBuzz {
    result=""

    checkDivis $1 3 && result="Fizz"
    checkDivis $1 5 && result="${result}Buzz"
    if [ -z $result ]; then
        echo $1
    else
        echo $result;
    fi
}

for number in {1..100}; do
    consul kv put hello/$number `fizzBuzz $number`
done