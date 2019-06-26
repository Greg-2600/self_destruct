#!/bin/sh

# in one line:
ps aux|grep $0|grep -v grep|awk {'print $2'}|xargs -n1 kill -9 $1
