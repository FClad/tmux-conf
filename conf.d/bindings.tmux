# Tmux bindings

set-window-option -g xterm-keys on			# Enable xterm keys

set-option -g prefix C-a					# Rebind action key to Ctrl-a

bind-key a send-prefix						# Ctrl-a + a to send 'Ctrl-a' to inner process

bind-key C-a last-window					# Ctrl-a twice to switch to the last active window (just like screen)


# Reload source file
bind-key r source-file ~/.tmux.conf \; display-message "Configuration reloaded"

# Move between panes
bind-key Up select-pane -U
bind-key Down select-pane -D
bind-key Left select-pane -L
bind-key Right select-pane -R


# Split windows
unbind %
bind	|	split-window -h					# Ctrl-a | to split horizontally
bind	-	split-window -v					# Ctrl-a - to split vertically
bind	m	command-prompt "split-window 'exec man %%'"


# Select, copy and paste
unbind [
unbind p
bind Escape copy-mode
bind p paste-buffer
bind-key -T copy-mode-emacs 'v' send-keys -X begin-selection
bind-key -T copy-mode-emacs 'y' send-keys -X copy-selection


# Layouts bindings
bind	C	source-file ~/.tmux/layouts/cdev.tmux


# Enable mouse integration
#set -g mouse on
#bind -n WheelUpPane		select-pane -t= \; copy-mode -e \; send-keys -M
#bind -n WheelDownPane	select-pane -t= \; send-keys -M
#
set-option -g -q mouse on
bind-key -T root PPage if-shell -F "#{alternate_on}" "send-keys PPage" "copy-mode -e; send-keys PPage"
bind-key -T copy-mode-vi PPage send-keys -X page-up
bind-key -T copy-mode-vi NPage send-keys -X page-down

