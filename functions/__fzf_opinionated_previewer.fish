function __fzf_opinionated_previewer
	for FIFIFI in $argv 
		if test -d $FIFIFI
			echo -n "<DIR>    "
		else if string match -r -q "binary" (file --mime $FIFIFI)
			echo -n "<BINARY> "
		else
			echo -n "<FILE>   "
		end

		du -sh $FIFIFI

		if test -d $FIFIFI
			ls -Axh1 --si --color=always $FIFIFI
		else if string match -r -q "binary" (file --mime $FIFIFI)
			hexdump -C -n 4096 $FIFIFI
			if test (du -sb $FIFIFI | cut -f1) -gt 4096
				echo "only first 4096 bytes printed"
			end
		else
			bat --style=numbers --color=always --wrap=auto \
		 		--terminal-width=(tput cols) \
				$FIFIFI
		end
	end
end
