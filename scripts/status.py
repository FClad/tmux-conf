#!/usr/bin/env python
# coding=UTF-8

import math, subprocess, sys
from psutil import cpu_percent, virtual_memory

def getvalue (registry, field):
	line = [l for l in registry.splitlines() if field in l][0]
	value = line.rpartition('=')[-1].strip()

	return value


def parsetime (time):
	if int (time) == 65535:
		return ''

	hours = int (time) / 60
	minutes = int (time) % 60

	result = ''

	if hours > 0:
		result += str (hours) + 'h'

	if minutes > 0:
		result += str (minutes) + 'm'

	return result


def batterystatus ():
	p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE)
	output = p.communicate()[0]

	# Retrieve battery load
	b_cur = int (getvalue (output, 'CurrentCapacity'))
	b_max = int (getvalue (output, 'MaxCapacity'))

	# Retrieve battery status
	connected = getvalue (output, 'ExternalConnected')
	charged = getvalue (output, 'FullyCharged')
	charging = getvalue (output, 'IsCharging')
	remaining = parsetime (getvalue (output, 'TimeRemaining'))

	b_per = b_cur * 100 / b_max

	out = 'Battery: %d%%' % b_per

	if charged == 'Yes' and connected == 'Yes':
		out += ' - Charged'
	else:
		if charging == 'Yes':
			out += ' - Charging'
			if remaining != '':
				out += ' (' + remaining + ' to full)'
		else:
			if remaining != '':
				out += ' - ' + remaining + ' remaining'

	# Colored output
	# color_green = '%{[32m%}'
	# color_yellow = '%{[1;33m%}'
	# color_red = '%{[31m%}'
	# color_reset = '%{[00m%}'
	# color_out = (
	#     color_green if len(filled) > 6
	#     else color_yellow if len(filled) > 4
	#     else color_red
	# )
	# out = color_out + out + color_reset
	
	return out


def getunread (account = '', mailbox = ''):
	# Build AppleScript command
	command = 'tell application "Mail" to return the unread count of '
	if len (account) > 0 and len (mailbox) > 0:
		command += 'mailbox "' + mailbox + '" of account "' + account + '"'
	else:
		command += 'inbox'

	# Run AppleScript as a subprocess
	p = subprocess.Popen(['osascript', '-e', command],
			stdout=subprocess.PIPE, stderr=subprocess.PIPE)

	# Retrieve script output
	output = p.communicate()[0]

	# Silently return 0 in case of error
	# (you do not want to mess up the status bar)
	if p.returncode != 0:
		return 0

	# And return the first (and only) value
	return int (output.splitlines()[0])


def unreadmail ():
	# Count unread emails in inbox
	unread = getunread ()

	# Count unread emails in custom mailboxes
	unread += getunread (account = 'Unistra', mailbox = 'Equipe RP')
	unread += getunread (account = 'Unistra', mailbox = 'Self')

	# Prepare ouput
	if unread > 0:
		out = str (unread) + ' unread email'
		if unread > 1:
			out += 's'
	else:
		out = 'No unread email'
	
	return out


def currenttrack ():
	command = 'tell application "iTunes"\n \
		if player state is playing then\n \
			set t_name to the name of the current track\n \
			set t_artist to the artist of the current track\n \
			return "Playing \'" & t_name as text & "\' from " & t_artist as text\n \
		end if\n \
		return ""\n \
	end tell\n'

	# Run AppleScript as a subprocess
	p = subprocess.Popen(['osascript', '-e', command],
			stdout=subprocess.PIPE)

	# Retrieve script output
	output = p.communicate()[0]

	# Silently return in case of error
	# (you do not want to mess up the status bar)
	if p.returncode != 0 or len (output) < 2:
		return ''

	return output[:-1] + ' - '


def resusage ():
	p_cpu = cpu_percent (1)
	p_mem = virtual_memory ().percent

	out = 'CPU: %.1f%%' % p_cpu
	out += '  MEM: %.1f%%' % p_mem

	return out


if __name__ == "__main__":
	if len (sys.argv) < 2:
		sys.exit (1)

	if sys.argv[1] == 'left':
		sys.stdout.write (resusage() + '  ' + batterystatus())
	elif sys.argv[1] == 'right':
		sys.stdout.write (currenttrack() + unreadmail())
	
	sys.exit (0)

