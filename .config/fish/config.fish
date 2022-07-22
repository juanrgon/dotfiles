#######################
# @juanrgon fish config
#######################

############
# Cheatsheet
############
# "set --universal" sets a variable in ALL fish shells, current and future
# "set --export" sets a variable in the current shell, and in its future child processes

#####################################
# Add my personal scripts to the PATH
#####################################
set --universal PERSONAL_SCRIPTS_DIR $HOME/.juan/bin                 # destination for my personal scripts
mkdir -p $PERSONAL_SCRIPTS_DIR                                       # Create personal scripts dir
chmod +x $PERSONAL_SCRIPTS_DIR/*                                     # Make personal scripts files executable
# NOTE using "set --universal" on fish_user_paths would cause it to get longer on each new shell
set --export fish_user_paths $PERSONAL_SCRIPTS_DIR $fish_user_paths  # add personal scripts dir to the PATH

#######################################
# Set code as EDITOR if it is installed
#######################################
if type --quiet code
    set --universal EDITOR code
end
