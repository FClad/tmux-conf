# Tmux statusbar settings

# Enable status bar (default is "on")
set-option -g status on

# other statusbar configs:
set-option -g status-interval 5
set-option -g status-utf8 on
set-option -g status-justify right

# center align window list
set-option -g status-justify centre 

# what is to be shown to the left on the status bar
set -g status-left-length 100
set-option -g status-left ' #[fg=blue]#(~/.tmux/scripts/status.py left)#[default]'

# what is to be shown to the right on the status bar
set -g status-right-length 100
set-option -g status-right '#[fg=blue]#(~/.tmux/scripts/status.py right) %A %d %B %k:%M#[default] '

