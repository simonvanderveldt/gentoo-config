# #!/usr/bin/env sh
# # .stowrc doesn't do shell expansion :|
# # See https://lists.gnu.org/archive/html/help-stow/2013-04/msg00008.html
# set -x
#
# # Stow doesn't traverse symlinks :(
# # Find current kernel directory
# KERNEL=$(readlink /usr/src/linux)
# echo $KERNEL
# stow -v --no-folding --target=/usr/src/$KERNEL kernel-config

#!/usr/bin/env sh
# .stowrc doesn't do shell expansion :|
# See https://lists.gnu.org/archive/html/help-stow/2013-04/msg00008.html
set -x

stow -v --no-folding --target=/usr/src kernel-config
