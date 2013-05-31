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
bind-key -t emacs-copy 'v' begin-selection
bind-key -t emacs-copy 'y' copy-selection


# Layouts bindings
bind	C	source-file ~/.tmux/layouts/cdev.tmux


# Enable mouse integration
set -g mode-mouse on						# Scrolling / text selection with the mouse
set -g mouse-resize-pane on					# Allows pane resizing with the mouse 
set -g mouse-select-pane on					# Allows pane switching with the mouse
set -g mouse-select-window on				# Allows tabs switching with the mouse

