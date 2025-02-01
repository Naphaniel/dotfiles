fish_config theme choose "Rosé Pine"

set fish_greeting

starship init fish | source

enable_transience

set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_once underscore
set -gx EDITOR nvim
set -gx PAGER less

# Solarized Dark & Green highlight
set -g man_blink -o f6c177
set -g man_bold -o c4a7e7
set -g man_standout -b c4a7e7
set -g man_underline -u f6c177

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

if test (tty) = "/dev/tty1"
	exec hyprland
end

zoxide init fish | source
