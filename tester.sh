#!/bin/bash

# Author: Robxxt
# Date: 02.08.2023
# Description:
# 	This is a simple automated test for the project philosophers
# 	that checks for some simple cases.

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

total_test_repetition=5
global_passed_tests=0
local_passed_tests=(0 0 0 0 0)
test_cases=(
	"5 800 200 200 7"
	"4 410 200 200 10"
	"1 800 200 200"
	"4 310 200 100"
	"4 200 205 200"
)
total_test_cases=${#test_cases[@]}
test_expected=(35 40 1 1 1)
options=("eating" "die")
total_tests_should_pass=$((total_test_cases * total_test_repetition))

for ((i = 0; i < total_test_cases; i++)); do
	IFS=' ' read -ra elements <<< "${test_cases[i]}"
	echo "$i TEST: ./philo ${elements[@]}"
	if [ $i -le 1 ]; then
		option=${options[0]}
	else
		option=${options[1]}
	fi
	for ((j = 0; j < total_test_repetition; j++)); do
		if [ $(./philo ${elements[@]} | grep $option | wc -l) -ge ${test_expected[i]} ]; then
			((local_passed_tests[i]++))
			((global_passed_tests++))
			echo -n "✅";
		else
			echo -n "💥";
		fi
	done
	echo ""
	echo "PASSED: [${local_passed_tests[i]} / $total_test_repetition]"
done

echo "FIRST TESTER:"
if [ $global_passed_tests -eq $total_tests_should_pass ]; then
	echo "${GREEN}Passsed!${RESET}"
else
	echo "${RED}Failed!${RESET}"
	echo "𐐘💥╾━╤デ╦︻ඞා"
fi


total_test_repetition=5
global_passed_tests=0
local_passed_tests=(0 0 0 0 0 0)
test_cases=(
	"5 800 200 200"
	"5 600 150 150"
	"4 410 200 200"
	"100 800 200 200"
	"105 800 200 200"
	"200 800 200 200"
)
option="die"
for ((i = 0; i < total_test_cases; i++)); do
	IFS=' ' read -ra elements <<< "${test_cases[i]}"
	echo "$i TEST: ./philo ${elements[@]}"
	for ((j = 0; j < total_test_repetition; j++)); do
		if [ $(timeout 3 ./philo ${elements[@]} | grep $option | wc -l) -eq 0 ]; then
			((local_passed_tests[i]++))
			((global_passed_tests++))
			echo -n "✅";
		else
			echo -n "💥";
		fi
	done
	echo 
done

echo "SECOND TESTER:"
if [ $global_passed_tests -eq $total_tests_should_pass ]; then
	echo "${GREEN}Passsed!${RESET}"
else
	echo "${RED}Failed!${RESET}"
	echo "𐐘💥╾━╤デ╦︻ඞා"
fi
