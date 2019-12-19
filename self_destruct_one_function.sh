#!/bin/bash
# in one function:

self_destruct() {
	ps aux|              # list all processes
	grep "$0"|           # find this one
	grep -v grep|        # remove grep artifact
	awk '{print $2}'|    # grab the 2nd item in processlist (pid)
	xargs -I {} kill -9 {} # send a kill signal to myself
}


self_destruct
