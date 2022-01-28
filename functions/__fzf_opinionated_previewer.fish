function __fzf_opinionated_previewer
	for FIFIFI in $argv
		if test -d $FIFIFI
			echo -n "<DIR>        "
			du -sh $FIFIFI

			ls -Axh1 --si --color=always $FIFIFI
		else if string match -r -q "symlink" (file --mime $FIFIFI)
			echo -n "<SYMLINK>    "
			du -sh $FIFIFI

			__fzf_opinionated_previewer (readlink -f $FIFIFI)
		else if string match -r -q "binary" (file --mime $FIFIFI)
			echo -n "<BINARY>     "
			du -sh $FIFIFI

			hexdump -C -n 4096 $FIFIFI
			if test (du -sb $FIFIFI | cut -f1) -gt 4096
				echo "only first 4096 bytes printed"
			end
		else
			echo -n "<FILE>       "
			du -sh $FIFIFI

			bat --style=numbers --color=always --wrap=auto \
				--terminal-width=(tput cols) \
				$FIFIFI
		end
	end
end