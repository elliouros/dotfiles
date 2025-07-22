#!/usr/bin/env nu

const cat = [
 r#' /\_/\ '#
 r#'(='.'=)'#
 r#'(")_(")'#
]

let config = [
  { chance: 1
    exec: {
      [ $"\e[1;38;5;4m($cat.0) Welcome, \e[1;38;5;211m(whoami)"
        $"($cat.1) \e[1;32mStartup Time:"
        $"\e[37m($cat.2) \e[0m($nu.startup-time)"
      ] | str join "\n"
    }
  }
]

def repeat [times --fold(-f)=[]] {
  let val = $in
  if ($times <= 0) {
    return $fold
  } else {
    $val
    | repeat ($times - 1) -f ($fold | append $val)
  }
}

let list = $config
| reduce -f [] {|it acc|
  $it.exec
  | repeat $it.chance
  | $acc ++ $in
}

let index = $list
| length
| 0..($in - 1)
| random int $in

$list | get $index | do $in
