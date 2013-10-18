# Layout file for system dashboard

selectp -t 0
splitw -v -p 50
selectp -t 0
splitw -h -p 50 'watch netstat -tpe'
selectp -t 2
splitw -h -p 30 'top'
selectp -t 2
splitw -h -p 50 'watch pstree'
selectp -t 0

