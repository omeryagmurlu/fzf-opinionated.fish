function __fzf_opinionated_find
    # Make sure that fzf uses fish to execute __fzf_preview_file.
    set --local --export SHELL (which fish)
    set --local selected (
        fd --hidden --follow --color=always --exclude=.git 2> /dev/null |
        fzf --ansi --prompt=❯❯❯ --preview='__fzf_opinionated_previewer {}' --preview-window right:60%:noborder --height 100% --bind='ctrl-p:toggle-preview'
    )

    if test $status -eq 0
        commandline --insert (echo $selected | string escape)
    end

    commandline --function repaint
end
