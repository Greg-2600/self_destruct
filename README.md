# self_destruct
ridiculous program that using multithreading and scoping to tell unix to kill this program itself


# in one function:
#self_destruct() {
#	ps aux|              # list all processes
#	grep $0|             # find this one
#	grep -v grep|        # remove grep artifact
#	awk {'print $2'}|    # grab the 2nd item in processlist (pid)
#	xargs -n1 kill -9 $1 # send a kill signal to myself
#}
#self_destruct

# or in one line:
#ps aux|grep $0|grep -v grep|awk {'print $2'}|xargs -n1 kill -9 $1
