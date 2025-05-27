# meow

These are my dotfiles for a very minimalistic Sway environment.

As the structure, `.gitignore` and `sway/config` would imply, I use sway, foot,
qutebrowser, helix, tofi, and nushell.

## usage

link a swaybar status provider a la i3blocks at `sway/status` or configure bar
status-command directly in `sway/config`. I symlink to my own provider nushell
script, [swayblocks.nu](https://github.com/elliouros/swayblocks.nu).

You will also probably want to configure your output, unless you use a display
at eDP-1 with a 1366x768@60hz mode and don't want your background on any other
screens.

Additionally, you might put your own background at `background` or, again, edit
sway config directly.

As tofi loads dramatically faster when not resolving font by pango, its config
points directly to `FreeMono.otf` (Arch `gnu-free-fonts`). Ensure that this
path is correct, or points to a font of your choice.
