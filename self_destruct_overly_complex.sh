#!/bin/sh
# ridiculous program that using multithreading and scoping to tell unix to kill this program itself


get_process_stack() {
# list all processes this process can see
	this_stack=$(ps aux)
	echo "$this_stack"
}


get_this_process() {
# iterate through a list of processes and find this one
	while read this_process_stack; do
		echo $this_process_stack|
			grep $0|
			grep -v grep
	done
}


get_this_pid() {
# get the pid of this process
	while read this_process_stack; do
		echo $this_process_stack|awk {'print $2'}
	done
}


get_this_pid_count() {
# count how many instances of this process there are
	this_pid_count=$(echo $(get_this_pid)|wc -l)
	echo $this_pid_count
}


kill_this_pid() {
# send a kill signal to this process
	for this_pid in $@; do
		kill -9 $this_pid
	done
}


main() {
# run this program
	# extend the namespace availability of this function
	export -f kill_this_pid

	this_pid_list=$(get_process_stack|get_this_process|get_this_pid)
	this_pid_count=$(echo "$this_pid_list"|get_this_pid_count)

	echo "$this_pid_list"|
		xargs -n1 -I{} -P $this_pid_count bash -c "kill_this_pid {}" 2>&1 >> /dev/null
}


main
