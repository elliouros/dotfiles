# config.nu

source ~/.local/zoxide.nu
$env.LANG = 'en_US.UTF-8'

$env.VISUAL = 'helix'
$env.config.buffer_editor = 'helix'
$env.config.edit_mode = 'vi'

$env.config.filesize.unit = 'binary'

$env.config.history.file_format = 'sqlite'

$env.PROMPT_COMMAND = {||
  # To show all directories fully, set $env.nu_full_dirs to true
  # To use default behavior, either hide-env nu_full_dirs or set it to 1
  # To show x amount of directories, set nu_full_dirs to x
  let full_dirs = $env.nu_full_dirs? | default 1
  pwd
  | str replace -r $'^($nu.home-path)' '~'
  | if ($full_dirs == true) {return $in} else {$in}
  | path split
  | [
    ...(
      $in
      | drop $full_dirs
      | each {||
        parse -r '(?<m>^\.?.)'
        | get 0.m
      }
    )
    ...($in | last $full_dirs)
  ]
  | if (($in | first) == '/') {update 0 ''} else {$in}
  | str join '/'
  | if ($in == '') {'/'} else {$in}
  | if ($env.LOGNAME == root) {(ansi rb) ++ $in} else {$in}
}

$env.PROMPT_COMMAND_RIGHT = {||
  $env.LAST_EXIT_CODE
  | if $in != 0 { $'(ansi rb)[($in)]' }
}

$env.PATH ++= [
  '~/.cargo/bin'
  '~/.local/share/gem/ruby/3.4.0/bin'
  '~/.local/bin'
  '~/.bin'
  '.'
]

def banner [] {
  source ~/.config/nushell/greet.nu
}
