# Tmux colorscheme

# panes:
set-option -g pane-border-fg white
set-option -g pane-border-bg default
set-option -g pane-active-border-fg green
set-option -g pane-active-border-bg default

# border colours (most excellent!)
set -g pane-active-border-bg default
set -g pane-active-border-fg blue

# clock-mode
set-window-option -g clock-mode-colour cyan
set-window-option -g clock-mode-style 24

# command/message line colors (dim = non-bold (cyan if in CLI))
set-option -g message-fg white
set-option -g message-bg black
set-option -g message-attr dim

# messages (I don't know what this does?) 
set-window-option -g mode-bg magenta
set-window-option -g mode-fg black

# default statusbar colors (bright = bold)
set-option -g status-fg white
set-option -g status-bg black
#set-option -g status-attr bright

# active window title colors (default: white, default, bright (= bold))
set-window-option -g window-status-current-fg white
set-window-option -g window-status-current-bg blue
set-window-option -g window-status-current-attr dim #bright

# window title colors (default: white, default, dim (= non-bold))
set-window-option -g window-status-fg white
set-window-option -g window-status-bg default
set-window-option -g window-status-attr dim

