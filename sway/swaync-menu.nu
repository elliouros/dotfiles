#!/usr/bin/env nu
let flags = [
  {name: 'reload-config'    command: {swaync-client -R -sw}            }
  {name: 'reload-css'       command: {swaync-client -rc -sw}           }
  {name: 'toggle-panel'     command: {swaync-client -t -sw}            }
  {name: 'toggle-dnd'       command: {swaync-client -d -sw}            }
  {name: 'inhibitors-clear' command: {swaync-client -Ic -sw}           }
  {name: 'hide-latest'      command: {swaync-client --hide-latest -sw}  }
  {name: 'close-latest'     command: {swaync-client --close-latest -sw} }
  {name: 'close-all'        command: {swaync-client -C -sw}            }
  {name: 'get-dnd' command: {
    notify-send "Do Not Disturb status:" (swaync-client -D -sw)
  }}
  {name: 'count' command: {
    notify-send "#Notifications:" (swaync-client -c -sw)
  }}
]

let action = $flags | get $.name
  | str join "\n"
  | tofi -c ~/.config/tofi/nc

if $action != '' {do ($flags | where name == $action | get $.command.0)}
