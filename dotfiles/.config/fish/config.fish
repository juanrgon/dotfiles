################
# My fish config
################

############
# Cheatsheet
############
# "set --universal" sets a variable in ALL fish shells, current and future
# "set --export" sets a variable in the current shell, and in its future child processes

#####################################
# Add my personal scripts to the PATH
#####################################
set --export PERSONAL_SCRIPTS_DIR $HOME/bin/juanrgon    # destination for my personal scripts
mkdir -p $PERSONAL_SCRIPTS_DIR                          # Create personal scripts dir

# NOTE using "set --universal" instead of "set --export" on fish_user_paths would cause it to get longer on each new shell
set --export fish_user_paths $PERSONAL_SCRIPTS_DIR $fish_user_paths  # add personal scripts dir to the PATH

##################################
# Add homebrew bin dir to the PATH
##################################
switch (uname)
    case Darwin
        if test -d /opt/homebrew/bin
            set --export fish_user_paths /opt/homebrew/bin $fish_user_paths
        end

        if test -d /opt/homebrew/sbin
            set --export fish_user_paths /opt/homebrew/sbin $fish_user_paths
        end
end

#################################
# Add Cargo's bin dir to the PATH
#################################
if test -d $HOME/.cargo/bin
    set --export fish_user_paths $HOME/.cargo/bin $fish_user_paths  # add personal scripts dir to the PATH
end

#######################################
# Set code as EDITOR if it is installed
#######################################
if type --quiet code
    set --universal EDITOR code
end

##############
# Setup zoxide
##############
if type --quiet code
    zoxide init fish | source
end
