# config.nu

$env.config.show_banner = false
$env.VISUAL = 'helix'
$env.config.buffer_editor = 'helix'
$env.config.edit_mode = 'vi'

$env.config.filesize.unit = 'binary'

# $env.config.history.file_format = 'sqlite'

$env.PROMPT_COMMAND = {||
  # To show all directories fully, set $env.nu_full_dirs to true
  # To use default behavior, either hide-env nu_full_dirs or set it to 1
  # To show x amount of directories, set nu_full_dirs to x
  let pwd = pwd | str replace -r $'^($env.HOME)' '~'
  if ($env.nu_full_dirs? == true) {return $pwd}

  let full_dirs = $env.nu_full_dirs? | default 1
  $pwd
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
  | str replace -r '^$' '/'
  | if ($env.LOGNAME == root) {$'(ansi rb)($in)'} else {$in}
}

$env.PROMPT_COMMAND_RIGHT = {||
  $env.LAST_EXIT_CODE
  | if $in != 0 { $'(ansi rb)[($in)]' }
}

$env.PATH ++= [
  '~/.cargo/bin'
  # '~/.local/share/gem/ruby/3.3.0/bin'
  '~/.local/bin'
  '~/.bin'
]
