# conda setup

function condainit
	eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
