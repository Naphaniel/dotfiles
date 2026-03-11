function _fzf_wrapper --description "Prepares some environment variables before executing fzf."
    # Make sure fzf uses fish to execute preview commands, some of which
    # are autoloaded fish functions so don't exist in other shells.
    # Use --function so that it doesn't clobber SHELL outside this function.
    set -f --export SHELL (command --search fish)

    # If neither FZF_DEFAULT_OPTS nor FZF_DEFAULT_OPTS_FILE are set, then set some sane defaults.
    # See https://github.com/junegunn/fzf#environment-variables
    set --query FZF_DEFAULT_OPTS FZF_DEFAULT_OPTS_FILE
    if test $status -eq 2
        # cycle allows jumping between the first and last results, making scrolling faster
        # layout=reverse lists results top to bottom, mimicking the familiar layouts of git log, history, and env
        # border shows where the fzf window begins and ends
        # height=90% leaves space to see the current command and some scrollback, maintaining context of work
        # preview-window=wrap wraps long lines in the preview window, making reading easier
        # marker=* makes the multi-select marker more distinguishable from the pointer (since both default to >)
        set --export FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"'
    end

    set -Ux FZF_DEFAULT_OPTS "
        --color=fg:#908caa,bg:#191724,hl:#ebbcba
        --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
        --color=border:#403d52,header:#31748f,gutter:#191724
        --color=spinner:#f6c177,info:#9ccfd8
        --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

    fzf $argv
end
