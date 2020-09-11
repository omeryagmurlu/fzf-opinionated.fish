function __fzf_opinionated_history
    # history merge incorporates history changes from other fish sessions
    history merge
    set --local command (
        history --null |
        fzf --prompt=❯❯❯ --read0 --tiebreak=index --query=(commandline)
    )

    if test $status -eq 0
        commandline --replace $command
    end

    commandline --function repaint
end
